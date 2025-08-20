# modules/resource_group/variables.tf
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_filter" {
  description = "Filter criteria for the resource group"
  type = list(object({
    Key   = string
    Values = list(string) # Changed to list(string) to match AWS provider expectation
  }))
}