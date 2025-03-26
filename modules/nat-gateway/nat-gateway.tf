resource "aws_eip" "nat_eip" {
  for_each = var.public_subnet_az_map

  vpc = "true"

  tags = {
    Name = "${var.nat_gateway_name}-nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  for_each = var.public_subnet_az_map

  allocation_id = aws_eip.nat_eip[each.key].id
  subnet_id     = each.value

  tags = {
    Name = "${var.nat_gateway_name}-nat-gw-${each.key}"
  }

  depends_on = [aws_eip.nat_eip]
}

resource "aws_route_table" "nat_to_private_rt" {
  for_each = var.private_subnet_map

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[each.value.az].id
  }

  tags = {
    Name = "${var.nat_gateway_name}-rt-${each.key}"
  }
}

resource "aws_route_table_association" "private_assoc" {
  for_each = var.private_subnet_map

  subnet_id      = each.value.subnet_id
  route_table_id = aws_route_table.nat_to_private_rt[each.key].id
}
