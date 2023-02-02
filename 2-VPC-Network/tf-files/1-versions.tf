# Terraform Block
terraform {
  required_version = "~> 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = "us-east-1" # N.Virginia #
  #region = "us-east-2" # Ohio region #
  #region  = "ap-south-1"   # mumbai region #
  profile = "cloud-admin" # iam-user #
  #profile = "default"      # aws root user #
}


