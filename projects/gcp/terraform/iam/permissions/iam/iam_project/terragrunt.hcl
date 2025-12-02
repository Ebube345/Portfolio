# 
# permissions that give to the iam project
# permission to generate service accounts inside the iam project 
# 

include "root" {
  path = find_in_parent_folders()
}

dependency "iam_project" {
  config_path = "../../../project"
}

dependency "iam_sa" {
  config_path = "../../../service_accounts/iam"
}

include "iam" {
  path = "${dirname(find_in_parent_folders())}/_env/iam/project.hcl"
}

inputs = {
  projects = [dependency.iam_project.outputs.project_id]
  mode     = "authoritative"
  bindings = {
    "roles/iam.serviceAccountAdmin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ],
    "roles/compute.networkAdmin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ],
    "roles/container.clusterAdmin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
    "roles/resourcemanager.projectIamAdmin" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
    "roles/iam.serviceAccountUser" = [
      "serviceAccount:${dependency.iam_sa.outputs.email}"
    ]
  }
}

/*
 *
 * Role Category,                 Impersonated SA Needs This Role
 * --------------------------------------------------------------
 * GKE Management,                roles/container.admin (Kubernetes Engine Admin) ; using cluster admin instead
 * Service Account Management,    roles/iam.serviceAccountAdmin (To create the new GKE node SA)
 * Permission Binding,            roles/resourcemanager.projectIamAdmin (To grant roles to the new GKE node SA)
 * Node Identity,                 roles/iam.serviceAccountUser (To assign the new GKE node SA to the node VMs)
 */
