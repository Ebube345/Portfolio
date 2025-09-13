include "root" {
  path = find_in_parent_folders()
}

include "group" {
  path = "${dirname(find_in_parent_folders())}/_env/group.hcl"
}

dependency "admin_group" {
  config_path = "../admin"
}

inputs = {
  id           = "bucket-access-group@ahiaplace.com"
  display_name = "Bucket Access Group"
  description  = "Group for users who need access to specific storage buckets"
  members      = [dependency.admin_group.outputs.id]
}