variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "nat_gateway_name" {
  description = "Prefix for naming resources"
  type        = string
}

variable "public_subnet_az_map" {
  description = "Map of AZ -> public subnet ID (for placing NAT GW)"
  type        = map(string)
}

variable "private_subnet_map" {
  description = <<EOT
Map of private subnets by name, containing:
- subnet_id
- az (e.g. ap-northeast-2a)

Example:
{
  "private-a" = {
    subnet_id = "subnet-abc"
    az        = "ap-northeast-2a"
  },
  "private-b" = {
    subnet_id = "subnet-def"
    az        = "ap-northeast-2b"
  }
}
EOT
  type = map(object({
    subnet_id = string
    az        = string
  }))
}
