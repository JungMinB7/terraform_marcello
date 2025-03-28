output "rds_endpoint" {
  value = aws_db_instance.rds-mysql.endpoint
}

output "rds_port" {
  value = aws_db_instance.rds-mysql.port
}

output "rds_username" {
  value = aws_db_instance.rds-mysql.username
}