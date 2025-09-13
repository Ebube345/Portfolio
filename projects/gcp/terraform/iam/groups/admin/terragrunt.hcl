include "root" {
    path = find_in_parent_folders()
}

include "group" {
    path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

inputs = {
    id = "ahia-admins@ahiaplace.com"
    domain = "ahiaplace.com"
    display_name = "Admin Group"
    description = "Group for administrators with full access to perform iam on root folder"
    members = ["developer@ahiaplace.com"]
}