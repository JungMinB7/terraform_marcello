output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = { for k, subnet in aws_subnet.subnet : k => subnet.id }
}