variable "cluster_name" {
    description = "Name of the KIND cluster"
    type = string
    default = "kind-cluster"
}

variable "github_token" {
    description = "Guthub PAT for maanging deploy keys"
    type = string
    sensitive = true
}

variable "github_owner" {
    description = "Github username"
    type = string
}

variable "github_repository" {
    description = "Github repository name for Flux sync"
    type = string
}

variable "flux_sync_path" {
    description = "Path in Git repo for Flux to sync"
    type = string
    default = "projects/gitops-with-flux/clusters/local"
}