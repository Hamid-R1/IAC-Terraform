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
