/*
* This will create the devops service account
* This service accont is in charge of being impersonated by members of the devops group to create gcp resources
*/

include "root" {
    path = find_in_parent_folders()
}

include "iam_sa" {
    path = "${dirname(find_in_parent_folders())}/_env/service-account.hcl"
}

# iam project
dependency "iam_project" {
    config_path = "../../project"
}

inputs = {
    names = ["devops"]
    project_id = dependency.iam_project.outputs.project_id
}