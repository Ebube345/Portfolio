locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  common_project = local.common_vars.common_project
}
include "root" {
    path = find_in_parent_folders()
}

include "vpc" {
    path = "${dirname(find_in_parent_folders())}/_env/network/vpc.hcl"
}

inputs = {
  project_id = local.common_vars.common_project
}
