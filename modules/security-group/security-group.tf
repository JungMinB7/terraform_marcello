resource "aws_security_group" "security_group" {
  name_prefix = "${var.name_prefix}-sg-"
  vpc_id      = var.vpc_id
  description = var.description

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = try(ingress.value.cidr_blocks, null)
      security_groups = try(ingress.value.security_groups, null)
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = try(egress.value.cidr_blocks, null)
    }
  }

  tags = {
    Name = "${var.name_prefix}-${var.security_group_name}"
  }
}
