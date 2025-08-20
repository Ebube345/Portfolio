# main.tf
module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name   = var.resource_group_name
  resource_group_filter = var.resource_group_filter
}

module "import_aws_resourcs" {
  source      = "./modules/import_resources"
  aws_region  = var.aws_region
  aws_profile = var.aws_profile
}
