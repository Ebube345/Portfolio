# variables.tf
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-north-1"
}
variable "aws_profile" {
  description = "AWS profile to deploy resources"
  type        = string
  default     = "default"
}

variable "resource_group_name" {
  description = "Name of the AWS resource group"
  type        = string
  default     = "ahia-resource-group"
}

variable "resource_group_filter" {
  description = "Filter criteria for the resource group"
  type = list(object({
    Key    = string
    Values = list(string) # Changed to list(string) to match AWS provider expectation
  }))
  default = [
    {
      Key    = "Environment"
      Values = ["dev"]
    }
  ]
}