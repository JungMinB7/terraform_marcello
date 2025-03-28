resource "aws_db_subnet_group" "res_subnet_group" {
  name       = "${var.rds_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.rds_name}-subnet-group"
  }
}

#일단은 rds mysql 용은 이렇게 짜기. 나중에 database/rds에 넣기
resource "aws_db_instance" "rds_mysql" {
  identifier             = "${var.rds_name}-db"
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                   = var.db_name        # ✅ name 가능
  username               = var.username
  password               = var.password
  port                   = var.port
  db_subnet_group_name   = aws_db_subnet_group.res_subnet_group.name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot    = true
  multi_az               = var.multi_az
}
