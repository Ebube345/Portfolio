
/**
  This will create the IAM Service account
*/

include "root" {
    path = find_in_parent_folders()
}

include "iam_sa" {
    path = "${dirname(find_in_parent_folders())}/_env/service-account.hcl"
}

dependency "iam_project" {
    config_path = "../../project"
}

inputs = {
    names = ["iam"]
    project_id = dependency.iam_project.outputs.project_id
}