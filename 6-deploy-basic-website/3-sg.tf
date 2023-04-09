############################
# Security Group
###############################
# Create Security Group
resource "aws_security_group" "web_sg" {
  name        = "hr_sg"
  description = "allow port 22-80"
  vpc_id      = aws_vpc.web_vpc.id
  tags = {
    "Name" = "hr_sg_web_server"
  }
  ingress {
    description = "allow port 22 from owner ip"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks = ["103.71.20.6/32"]		#from owner ip
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow port 80 for all"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
