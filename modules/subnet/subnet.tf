resource "aws_subnet" "subnet" {
  for_each = var.subnet_map

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = {
    Name        = "${var.subnet_name}-${each.key}"
    Type        = each.value.type      # "public", "private", "db"
    AZ          = each.value.az        # AZ도 태그로 남겨줌
    Environment = var.environment
  }
}
