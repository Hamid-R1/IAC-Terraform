###################
# aws_instance
###################
resource "aws_instance" "web_instance" {
  ami                         = "ami-0aa7d40eeae50c9a9"
  instance_type               = "t2.micro"
  key_name                    = "hr-web-n-virginia"
  subnet_id                   = aws_subnet.web_subnet.id
  associate_public_ip_address = "true"
  user_data                   = file("5-deploy_website.sh")
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  tags = {
    "Name" = "hr_server"
  }
}

