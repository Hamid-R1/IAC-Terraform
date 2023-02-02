# ec2-instance
resource "aws_instance" "web-instance" {
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  count         = 2           #Meta-Argument
  key_name      = "hr-web-us-east-1"
  tags = {
    "Name" = "my-instance-${count.index}"   #-tags can be like this,- my-instance-0, my-instance-1 #
  }
}
