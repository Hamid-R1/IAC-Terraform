###################
# VPC
###################
resource "aws_vpc" "web_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "hr_vpc"
  }
}

# subnet
resource "aws_subnet" "web_subnet" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "hr_subnet"
  }
}

# igw
resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id
  tags = {
    "Name" = "hr_igw"
  }
}

# route_table
resource "aws_route_table" "wb_rt" {
  vpc_id = aws_vpc.web_vpc.id
  tags = {
    "Name" = "hr_rt"
  }
}

# igw attach to route_table
resource "aws_route" "web_igw_attach" {
  route_table_id         = aws_route_table.wb_rt.id
  gateway_id             = aws_internet_gateway.web_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# subnet association
resource "aws_route_table_association" "web_subnet_associatiom" {
  route_table_id = aws_route_table.wb_rt.id
  subnet_id      = aws_subnet.web_subnet.id
}



























