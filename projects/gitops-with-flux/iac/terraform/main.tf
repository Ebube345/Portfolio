# Provision KIND cluster
resource "kind_cluster" "this" {
    name = var.cluster_name
    node_image = "kindest/node:v1.29.2"
    wait_for_ready = true

    kind_config {
        kind = "Cluster"
        api_version = "kind.x-k8s.io/v1alpha4"

        node {
            role = "control-plane"
        }

        node {
            role = "worker"
        }
    }
}

# Generate SSH Key pair for Flux Git access
resource "tls_private_key" "flux" {
    algorithm = "ECDSA"
    ecdsa_curve = "P256"
}

# Add public key as deploy key to Github repo (read/write for flux to commit if needed)
resource "github_repository_deploy_key" "flux" {
    title = "Flux Deploy Key"
    repository = var.github_repository
    key = tls_private_key.flux.public_key_openssh
    read_only = false
}

# Configure Flux provider with KIND cluster credentials
provider "flux" {
    kubernetes  = {
        host = kind_cluster.this.endpoint
        client_certificate = base64decode(kind_cluster.this.client_certificate)
        client_key = base64decode(kind_cluster.this.client_key)
        cluster_ca_certificate = base64decode(kind_cluster.this.cluster_ca_certificate)
    }
    git = {
        url = "ssh://git@github.com/${var.github_owner}/${var.github_repository}.git"
        ssh = {
            username = "git"
            private_key = tls_private_key.flux.private_key_pem
        }
    }
}

# Bootstrap Flux: Installs controllers and configures Git sync
resource "flux_bootstrap_git" "this" {
    depends_on = [github_repository_deploy_key.flux]

    path = var.flux_sync_path
    embedded_manifests = true # Include Flux manifests in the commit
}