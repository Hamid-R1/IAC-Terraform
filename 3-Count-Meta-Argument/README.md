## Count (Meta-Arguments):-
- For creating multiple resource (aws services) according to a count, as the name suggests count can be used inside the resource block to specify how many resources, you would like to create.
- You do not need to write the same resource block again if you want to create more than one resource.
- for ex, see below, here we want to create 2 instances:-
```t
# ec2-instance
resource "aws_instance" "web-instance" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  count         = 2           #Meta-Argument
  key_name      = "hr-web-us-east-1"
  tags = {
    "Name" = "my-instance-${count.index}"  #-tags can be like this,- my-instance-0, my-instance-1 #
  }
}
```

## terraform .tf files
- 1-versions.tf
- 2-main.tf

### 1-versions.tf
```t
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
  profile = "cloud-admin" # iam-user #
}
```

### 2-main.tf
```t
# ec2-instance
resource "aws_instance" "web-instance" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  count         = 2           #Meta-Argument
  key_name      = "hr-web-us-east-1"
  tags = {
    "Name" = "my-instance-${count.index}"  #-tags can be like this,- my-instance-0, my-instance-1 #
  }
}
```

## Execute Terraform Commands
```t
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan

# Terraform Apply
terraform apply -auto-approve

# Terraform Destroy
terraform destroy -auto-approve
```