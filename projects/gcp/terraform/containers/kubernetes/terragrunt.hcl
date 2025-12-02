locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  common_project = local.common_vars.common_project
}
include "root" {
    path = find_in_parent_folders()
}

include "kubernetes" {
    path = "${dirname(find_in_parent_folders())}/_env/container/kubernetes.hcl"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "iam_sa" {
  config_path = "../../iam/service_accounts/iam"
}

inputs = {
  project_id = local.common_vars.common_project
  name = "ahia-k8s-cluster"
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network =  dependency.vpc.outputs.network.network.name
  subnetwork = dependency.vpc.outputs.subnets["us-central1/subnet-us-central1-pub"].name
  ip_range_pods              = "subnet-us-central1-pub-pods-range"
  ip_range_services          = "subnet-us-central1-pub-services-range"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  istio                      = true
  cloudrun                   = true
  dns_cache                  = false

  node_pools = [
   {
     name                        = "cluster-node-pool"
      machine_type                = "e2-medium"
      node_locations              = "us-central1-b"
      min_count                   = 1
      max_count                   = 2
      spot                        = false
      disk_size_gb                = 50
      disk_type                   = "pd-standard"
      image_type                  = "COS_CONTAINERD"
      logging_variant             = "DEFAULT"
      auto_repair                 = true
      auto_upgrade                = true
      #service_account             = module.ahia-k8s-cluster.service_account #dependency.iam_sa.outputs.email
      preemptible                 = false
      initial_node_count          = 1
   }
  ]
}
