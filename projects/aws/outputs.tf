# outputs.tf
output "resource_group_arn" {
  description = "ARN of the created resource group"
  value       = module.resource_group.resource_group_arn
}