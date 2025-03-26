variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "security_group_name" {
  type        = string
  description = "Name tag for SG"
}

variable "description" {
  type        = string
  description = "Description for the SG"
}

variable "ingress_rules" {
  type = list(object({
    description     = string
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
}

variable "egress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
