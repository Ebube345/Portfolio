# Using a null_resource to execute a local script to fetch resource IDs
resource "null_resource" "fetch_resources" {
  provisioner "local-exec" {
    command = <<EOT
      #!/bin/bash
      set -e
      # Ensure AWS CLI is installed
      if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it to proceed."
        exit 1
      fi

      # Create a temporary directory for output
      mkdir -p ./resource_data
      cd ./resource_data

      # Fetch EC2 instances
      aws ec2 describe-instances --region ${var.aws_region} --profile ${var.aws_profile} --query 'Reservations[].Instances[].[InstanceId]' --output text > ec2_instances.txt

      # Fetch S3 buckets
      aws s3api list-buckets --region ${var.aws_region} --profile ${var.aws_profile} --query 'Buckets[].Name' --output text > s3_buckets.txt

      # Fetch IAM roles
      aws iam list-roles --region ${var.aws_region} --profile ${var.aws_profile} --query 'Roles[].RoleName' --output text > iam_roles.txt

      # Fetch Security Groups
      aws ec2 describe-security-groups --region ${var.aws_region} --profile ${var.aws_profile} --query 'SecurityGroups[].GroupId' --output text > security_groups.txt
    
      # Fetch VPCs
      aws ec2 describe-vpcs --region ${var.aws_region} --profile ${var.aws_profile} --query "Vpcs[*].{ID:VpcId}" --output text > vpcs.txt

      # Fetch Subnets
      aws ec2 describe-subnets --region ${var.aws_region} --profile ${var.aws_profile} --query "Subnets[*].{SubnetId:SubnetId}" --output text > subnets.txt

      # Fetch Internet Gateways
      aws ec2 describe-internet-gateways --region ${var.aws_region} --profile ${var.aws_profile} --output text > internet_gateways.txt
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# Data source to read the fetched resource IDs
data "local_file" "ec2_instances" {
  filename = "./resource_data/ec2_instances.txt"
  depends_on = [null_resource.fetch_resources]
}

data "local_file" "s3_buckets" {
  filename = "./resource_data/s3_buckets.txt"
  depends_on = [null_resource.fetch_resources]
}

data "local_file" "iam_roles" {
  filename = "./resource_data/iam_roles.txt"
  depends_on = [null_resource.fetch_resources]
}

data "local_file" "security_groups" {
  filename = "./resource_data/security_groups.txt"
  depends_on = [null_resource.fetch_resources]
}

data "local_file" "vpcs" {
  filename = "./resource_data/vpcs.txt"
  depends_on = [null_resource.fetch_resources]
}

data "local_file" "subnets" {
  filename = "./resource_data/subnets.txt"
  depends_on = [null_resource.fetch_resources]
}

data "local_file" "internet_gateways" {
  filename = "./resource_data/internet_gateways.txt"
  depends_on = [null_resource.fetch_resources]
}
# Generating import blocks for EC2 instances
/**
resource "terraform_data" "ec2_import" {
  for_each = toset(split("\n", trimspace(data.local_file.ec2_instances.content)))
  input = {
    id = each.key
  }

  provisioner "local-exec" {
    command = <<EOT
      echo 'import {
        id = "${each.key}"
        to = aws_instance.ec2_${replace(each.key, "-", "_")}
      }' >> import_blocks.tf
    EOT
  }
}

# Generating import blocks for S3 buckets
resource "terraform_data" "s3_import" {
  for_each = toset(split("\n", trimspace(data.local_file.s3_buckets.content)))
  input = {
    id = each.key
  }

  provisioner "local-exec" {
    command = <<EOT
      echo 'import {
        id = "${each.key}"
        to = aws_s3_bucket.bucket_${replace(each.key, "-", "_")}
      }' >> import_blocks.tf
    EOT
  }
}
*/

# Generating import blocks for IAM roles
/*
resource "terraform_data" "iam_import" {
  for_each = toset(split("\t", trimspace(data.local_file.iam_roles.content)))
  input = {
    id = each.key
  }

  provisioner "local-exec" {
    command = <<EOT
      echo 'import {
        id = "${each.key}"
        to = aws_iam_role.role_${replace(each.key, "-", "_")}
      }' >> import_blocks.tf
    EOT
  }
}

# Generating import blocks for Security Groups
resource "terraform_data" "sg_import" {
  for_each = toset(split("\t", trimspace(data.local_file.security_groups.content)))
  input = {
    id = each.key
  }

  provisioner "local-exec" {
    command = <<EOT
      echo 'import {
        id = "${each.key}"
        to = aws_security_group.sg_${replace(each.key, "-", "_")}
      }' >> import_blocks.tf
    EOT
  }
}

# TODO: Move this to a seperate module and import the cidr_block from the vpc imported in this module
resource "aws_vpc" "this" {
  cidr_block           = "172.31.0.0/16"        # <- from describe-vpcs
  instance_tenancy     = "default"            # default or dedicated
  enable_dns_support   = true                 # from describe-vpc-attribute
  enable_dns_hostnames = true                 # from describe-vpc-attribute
}
*/