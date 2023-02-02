# Meta Arguments
- Can be used with any resource to change the behavior of resources,
- in terraform we have these types of meta arguments -   count, for_each, provider, depends_on, lifecycle, Provisioners & Connections

## For_each(Meta-Argument)
- To create multiple resources according to a map, or set of strings,
- here we see for_each with set of strings(toset)  & for_each with Maps

### for_each with set of strings(toset) funtion
```t
for_each = toset(["db-s3-bucket-db1", "db-s3-bucket-db2"])
/* Explanation:-
 each.value == give 2 values which means create 2 resources
  -1st resource: db-s3-bucket-db1
  -2nd resource: db-s3-bucket-db2
*/
```

### for_each with Maps
```t
 for_each = {
    test-env = "app-s3-bucket-app1"
    dev-env = "app-s3-bucket-app2"
  }
/* Explanation
each.key = give 2 keys
  -1st key: test-env
  -2nd key: dev-env

each.value = give 2 values
  -1st value: app-s3-bucket-app1
  -2nd value: app-s3-bucket-app2
*/
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
# without for_each 
resource "aws_s3_bucket" "web-s3" {
  bucket = "web-s3-bucket-web1"
  tags = {
    Name = "bucket-for-web1"
  }
}


# for_each with set of strings(toset) funtion
resource "aws_s3_bucket" "db-s3" {
  for_each = toset(["db-s3-bucket-db1", "db-s3-bucket-db2"])
  bucket   = each.value       #"${each.value}"
  tags = {
    "Name" = each.value       #"${each.value}"
  }
}
# Notes:-  each.value == each.key (gives same value)#


# for_each with  maps
resource "aws_s3_bucket" "app-s3" {
  for_each = {
    test-env = "app-s3-bucket-app1"
    dev-env = "app-s3-bucket-app2"
  }
  bucket =  "${each.key}-${each.value}"
  tags = {
    environment = each.key      #"${each.key}"
    Name =  each.value          #"${each.value}"
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
