
/**
  * terragrunt function to create a service account
*/

locals {
    billing_account = yamldecode(file(find_in_parent_folders("billing_vars.yaml"))).billing_account
}

terraform {
    source = "tfr:///terraform-google-modules/service-accounts/google?version=4.5.3"
}

inputs = {
    billing_account = local.billing_account # optional for assigning billing account roles
    prefix = "ahiaplace-sa"
}