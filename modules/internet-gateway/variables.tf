variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "internet_gateway_name" {
  description = "Prefix for naming resources"
  type        = string
}

# variable "public_subnet_ids" {
#   description = "List of public subnet IDs to associate with the public route table"
#   type        = list(string)
# }

variable "public_subnet_map" {
  type = map(string)
  description = "Map of public subnet name => subnet ID"
}