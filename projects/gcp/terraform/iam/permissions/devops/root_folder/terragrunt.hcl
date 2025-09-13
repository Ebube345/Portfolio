
/**
  This will assign iam permissions to the root folder of the project
*/

include "root" {
    path = find_in_parent_folders()
}

include "iam_folder" {
    path = "${dirname(find_in_parent_folders())}/_env/iam/folder.hcl"
}

# since the project will be under the shared folder we will grab it using the dependency block
dependency "root_folder" {
    config_path = "../../../../common/folders/root"
}

dependency "devops_sa" {
    config_path = "../../../service_accounts/devops"
}

inputs = {
    folders = [dependency.root_folder.outputs.id]
    mode = "authoritative"
    bindings = {
        "roles/resourcemanager.projectCreator" = [
            "serviceAccount:${dependency.devops_sa.outputs.email}"
        ]
    }
}