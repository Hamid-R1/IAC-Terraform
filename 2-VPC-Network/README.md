# AWS VPC Network creation

## Terraform scripts for these AWS Services
- vpc
- subnet
- internet gateway
- route table
- security group
- ec2-instance (within this vpc network)

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
  #region = "us-east-2" # Ohio region #
  #region  = "ap-south-1"   # mumbai region #
  profile = "cloud-admin" # iam-user #
  #profile = "default"      # aws root user #
}
```

### 2-main.tf
```t
############ Complete VPC Network #####################
resource "aws_vpc" "web-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "my-vpc"
  }
}

resource "aws_subnet" "web-subnet" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "my-subnet"
  }
}

resource "aws_internet_gateway" "web-igw" {
  vpc_id = aws_vpc.web-vpc.id
  tags = {
    "Name"  = "my-igw"
    "owner" = "cloud-admin"
  }
}

resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.web-vpc.id
  tags = {
    "Name" = "my-igw"
  }
}

resource "aws_route" "rt-igw" {
  route_table_id         = aws_route_table.web-rt.id
  gateway_id             = aws_internet_gateway.web-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "web-sb-association" {
  route_table_id = aws_route_table.web-rt.id
  subnet_id      = aws_subnet.web-subnet.id
}


############################
# Security Group
###############################
# Create Security Group
resource "aws_security_group" "web-sg" {
  name        = "my-sg"
  description = "allow SSH, http, https"
  vpc_id = aws_vpc.web-vpc.id
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#######################################
# ec2-instance
########################################
resource "aws_instance" "web-instance" {
  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  key_name = "hr-web-us-east-1"
  subnet_id = aws_subnet.web-subnet.id
  associate_public_ip_address = "true"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  tags = {
    "Name" = "my-instance"
    "owner" = "hamid"
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
