include "root" {
    path = find_in_parent_folders()
}
dependency "iam_k8s-sa" {
    config_path = "../../../../containers/kubernetes"
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
    mode = "additive"
    bindings = {
        "roles/container.nodeServiceAgent" : [
            "serviceAccount:${dependency.iam_k8s-sa.outputs.service_account}"
        ]
    }
}
