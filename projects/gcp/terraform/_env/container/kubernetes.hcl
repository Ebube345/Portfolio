/**
  * terragrunt function to create a kubernetes cluster
*/

locals {
    region = yamldecode(file(find_in_parent_folders("region_vars.yaml"))).region
}

terraform {
    source = "tfr:///terraform-google-modules/kubernetes-engine/google?version=17.1.0"
}

inputs = {
    region = local.region
}

