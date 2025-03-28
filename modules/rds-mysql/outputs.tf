output "rds_endpoint" {
  value = aws_db_instance.rds_mysql.endpoint
}

output "rds_port" {
  value = aws_db_instance.rds_mysql.port
}

output "rds_username" {
  value     = aws_db_instance.rds_mysql.username
  sensitive = true
}

output "rds_password" {
  value     = aws_db_instance.rds_mysql.password
  sensitive = true
}