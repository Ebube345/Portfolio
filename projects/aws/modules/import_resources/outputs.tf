# Output the path to the generated import blocks file
output "import_blocks_file" {
  value = "${path.module}/import_blocks.tf"
  description = "Path to the generated Terraform import blocks file"
}
