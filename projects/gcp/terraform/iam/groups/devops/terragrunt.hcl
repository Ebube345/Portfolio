include "root" {
    path = find_in_parent_folders()
}

include "group" {
    path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

inputs = {
    id = "ahia-devops-team@ahiaplace.com"
    domain = "ahiaplace.com"
    display_name = "ahia-devops"
    description = "ahia devops group"
    members = ["developer@ahiaplace.com"]
}