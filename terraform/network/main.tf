resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment_name}-VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.environment_name
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(var.availability_zones, 0)
  cidr_block              = var.subnet1_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment_name}-public-subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = element(var.availability_zones, 1)
  cidr_block              = var.subnet2_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.environment_name}-public-subnet2"
  }
}

resource "aws_eip" "nat_gateway1_eip" {
  domain = "vpc"
  tags   = {
    Name = "NatGateway1EIP"
  }
}

resource "aws_eip" "nat_gateway2_eip" {
  domain = "vpc"
  tags   = {
    Name = "NatGateway2EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.nat_gateway1_eip.id
  subnet_id     = aws_subnet.public_subnet1.id
}

resource "aws_nat_gateway" "nat_gateway2" {
  allocation_id = aws_eip.nat_gateway2_eip.id
  subnet_id     = aws_subnet.public_subnet2.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment_name}-public-route-table"
  }
}

resource "aws_route" "default_public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}