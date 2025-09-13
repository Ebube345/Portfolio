include "group" {
    path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

dependency "admin_group" {
    config_path = "../admin"
}

inputs = {
    id = "ahia-terragrunt@ahiaplace.com"
    domain = "ahiaplace.com"
    display_name = "ahia-terragrunt"
    description = "Group for administrators with full access to perform iam on terragrunt project"
    members = []
}