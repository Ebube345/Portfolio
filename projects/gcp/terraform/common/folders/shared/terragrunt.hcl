 

include "root" {
    path = find_in_parent_folders()
}

include "folder" {
    path = "${dirname(find_in_parent_folders())}/_env/folder.hcl"
}

# since this folder is under the rot folder we will use dependency to get the parent folder
dependency "root_folder" {
    config_path = "../root"
}

inputs = {
    parent = dependency.root_folder.outputs.id
    names = ["ahia-shared"]
}