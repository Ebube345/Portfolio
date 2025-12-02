include "root" {
    path = find_in_parent_folders()
}

dependency "iam_sa" {
    config_path = "../../../service_accounts/iam"
}

dependency "iam_project" {
    config_path = "../../../project"
}

include "sa_allow" {
    path = "${dirname(find_in_parent_folders())}/_env/iam/compute_network.hcl"
}

inputs = {
    service_account_address =  dependency.iam_sa.outputs.email
    project_id = dependency.iam_project.outputs.project_id
    project_roles = ["roles/compute.networkAdmin"]
    prefix = "sa"
}
