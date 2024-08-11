resource "aws_subnet" "subnet-public-01a" {
  vpc_id     = aws_vpc.vpc-01.id
  cidr_block = var.dev_subnet1_cidr_block
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-public-01a"
    Environment = "${var.environment}"
  }
}

resource "aws_internet_gateway" "gw-01" {
  vpc_id = aws_vpc.vpc-01.id

  tags = {
    Name = "gw-01"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "rt-01" {
  vpc_id = aws_vpc.vpc-01.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-01.id
  }
tags = {
  Name = "rt-01"
  Environment = "${var.environment}"
 }
}

resource "aws_route_table_association" "art-01a" {
 subnet_id   = aws_subnet.subnet-public-01a.id
 route_table_id = aws_route_table.rt-01.id
}
