/*
* Create the root folder, all the resources will be created under this folder
*/

include "root" {
    path = find_in_parent_folders()
}

include "folder" {
    path = "${dirname(find_in_parent_folders())}/_env/folder.hcl"
}
inputs = {
    names = ["ahia-common"]
}