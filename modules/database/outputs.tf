output "rds_endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "RDS DB endpoint"
}

output "rds_instance_id" {
  value       = aws_db_instance.this.id
  description = "RDS instance ID"
}