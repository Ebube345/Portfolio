# Defining variables for the module
variable "aws_region" {
  description = "The AWS region to import resources from"
  type        = string
}

variable "aws_profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "default"
}

