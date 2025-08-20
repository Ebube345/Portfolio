# modules/resource_group/outputs.tf
output "resource_group_arn" {
  description = "ARN of the created resource group"
  value       = aws_resourcegroups_group.this.arn
}