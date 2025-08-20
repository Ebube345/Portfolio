# modules/resource_group/main.tf
resource "aws_resourcegroups_group" "this" {
  name        = var.resource_group_name
  description = "Resource group for resources matching specified criteria"

  resource_query {
    type = "TAG_FILTERS_1_0"
    query = jsonencode({
      ResourceTypeFilters = ["AWS::AllSupported"]
      TagFilters = var.resource_group_filter
    })
  }
}