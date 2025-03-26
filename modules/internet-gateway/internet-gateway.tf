resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.internet_gateway_name}-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.internet_gateway_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = var.public_subnet_map

  subnet_id      = each.value
  route_table_id = aws_route_table.public_rt.id
}
