# Meta Arguments
- Can be used with any resource to change the behavior of resources,
- in terraform we have these types of meta arguments -   count, for_each, provider, depends_on, lifecycle, Provisioners & Connections

## Provider(Meta Argument)
- The primary reason for this is to support multiple regions for a cloud platform
- if you use multiple providers then you will have to use provider meta-argument in a particular resource for non-default providers, it means calling non-default provider,
- for ex:-
```t
-within provider block define this argument-        alias = "mumbai"
-within resource block define this meta-argument-   provider = aws.mumbai
```

## terraform .tf files
### 1-main.tf
```t
# Provider Block(default provider)
provider "aws" {
  region = "us-east-1" # N.Virginia #
  profile = "cloud-admin" # iam-user #
}

# Non-default provider
provider "aws" {
  alias = "mumbai"
  region = "ap-south-1"
}


# create ec2-instance in 'us-east-1' (default provider)
resource "aws_instance" "web-instance" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  key_name      = "hr-web-us-east-1"
  tags = {
    "Name" = "my-instance"
  }
}

# create ec2-instance in 'ap-south-1' (consider from non-default provider block)
resource "aws_instance" "web-instance-1" {
  ami           = "ami-01a4f99c4ac11b03c"
  instance_type = "t2.micro"
  key_name      = "hr-web-ap-south-1"
  provider = aws.mumbai     #Meta-Argument
  tags = {
    "Name" = "my-instance"
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
