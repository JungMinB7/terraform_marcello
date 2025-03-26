output "internet_gateway_id" {
  description = "ID of the created Internet Gateway"
  value       = aws_internet_gateway.internet_gateway.id
}

# output "subnet_ids" {
#   description = "Map of subnet names to IDs"
#   value       = { for k, subnet in aws_subnet.subnet : k => subnet.id }
# }

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_rt.id
}