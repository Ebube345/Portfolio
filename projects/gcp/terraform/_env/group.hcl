
/**
  * terragrunt function to create a group
*/

// run gcloud organizations list to get the customer id 
locals {
    customer_id = yamldecode(file(find_in_parent_folders("common_vars.yaml"))).customer_id
}

terraform {
    source = "tfr:///terraform-google-modules/group/google?version=0.7.0"
}

inputs = {
    customer_id = local.customer_id
}