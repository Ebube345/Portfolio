include "root" {
    path = find_in_parent_folders()
}

dependency "bucket_access_group" {
    config_path = "../../../groups/bucket-access"
}

include "bucket_permissions" {
    path = "${dirname(find_in_parent_folders())}/_env/iam/storage-bucket.hcl"
}

inputs = {
    storage_buckets = ["ahiaplace-terragrunt-state"]
    mode = "additive"
    bindings = {
        "roles/storage.admin" = [
            "group:${dependency.bucket_access_group.outputs.id}"
        ]
    }
}