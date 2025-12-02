include "root" {
    path = find_in_parent_folders()
}

dependency "iam_sa" {
    config_path = "../../../service_accounts/iam"
}
dependency "iam_k8s-sa" {
    config_path = "../../../../containers/kubernetes"
}

dependency "admin_group" {
    config_path = "../../../groups/admin"
}

dependency "iam_project" {
    config_path = "../../../project"
}

include "sa_allow" {
    path = "${dirname(find_in_parent_folders())}/_env/iam/service-account.hcl"
}

inputs = {
    service_accounts = [dependency.iam_k8s-sa.outputs.service_account]
    project = dependency.iam_project.outputs.project_id
    mode = "authoritative"
    bindings = {
        "roles/iam.serviceAccountTokenCreator" : [
            "group:${dependency.admin_group.outputs.id}",
            #"serviceAccount:${dependency.iam_sa.outputs.email}"
        ]
        "roles/iam.serviceAccountUser" = [
            "group:${dependency.admin_group.outputs.id}",
            #"serviceAccount:${dependency.iam_sa.outputs.email}"
        ]
    }
}
