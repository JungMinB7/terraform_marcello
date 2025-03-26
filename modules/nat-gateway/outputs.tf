output "nat_gateway_ids" {
  description = "Map of AZ to NAT Gateway ID"
  value       = { for k, nat in aws_nat_gateway.nat_gateway : k => nat.id }
}
