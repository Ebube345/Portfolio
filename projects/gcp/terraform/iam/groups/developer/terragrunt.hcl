include "root" {
    path = find_in_parent_folders()
}

include "group" {
    path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

inputs = {
    id = "ahia-developer-team@ahiaplace.com"
    domain = "ahiaplace.com"
    display_name = "ahia-developers"
    description = "ahia developer group"
    members = ["developer@ahiaplace.com"]
}