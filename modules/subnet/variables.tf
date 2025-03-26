variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Prefix for subnet names"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g. dev, prod)"
  type        = string
}

variable "subnet_map" {
  description = <<EOT
A map of subnets. Each item should include:
- cidr_block
- az (e.g. ap-northeast-2a)
- type: public / private / db
- assign_public_ip: true/false

Example:
{
  "public-a-openvpn" = {
    cidr_block        = "10.0.1.0/24"
    az                = "ap-northeast-2a"
    type              = "public"
    assign_public_ip  = false
  },
  "public-b-alb" = {
    cidr_block        = "10.0.2.0/24"
    az                = "ap-northeast-2b"
    type              = "public"
    assign_public_ip  = true
  },
  "private-a" = {
    cidr_block = "10.0.3.0/24"
    az         = "ap-northeast-2a"
    type       = "private"
  },
  "db-b" = {
    cidr_block = "10.0.4.0/24"
    az         = "ap-northeast-2b"
    type       = "db"
  }
}
EOT
  type = map(object({
    cidr_block       = string
    az               = string
    type             = string
    assign_public_ip = optional(bool)
  }))
}