resource "aws_vpc" "saradhi-terraform" {
    cidr_block = var.vpc_cidr
    tags = merge(var.tags, { Name = "main-vpc" })
}

resource "aws_subnet" "saradhi-subnet" {
    for_each = toset(var.public_subnets)
    vpc_id = aws_vpc.saradhi-terraform.id
    cidr_block = each.value
    availability_zone = var.availability_zone[0]
    tags = merge(var.tags, { Tier = "public" })
  
}

resource "aws_internet_gateway" "saradhi-igw" {
  vpc_id = aws_vpc.saradhi-terraform.id
}

resource "aws_route_table" "saradhi-route" {
  vpc_id = aws_vpc.saradhi-terraform.id
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.saradhi-route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.saradhi-igw.id
}

resource "aws_route_table_association" "saradhi-route" {
  for_each = aws_subnet.saradhi-subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.saradhi-route.id
}