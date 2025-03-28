resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.rds_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.rds_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "rds" {
  identifier              = "${var.rds_name}-db"
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  #name                    = var.db_name    ### mysql에선 쓰기 postgreSQL에선 에러남남
  username                = var.username
  password                = var.password
  port                    = var.port
  db_subnet_group_name    = aws_db_subnet_group.res_subnet_group.name
  vpc_security_group_ids  = [var.security_group_id]
  skip_final_snapshot     = true
  multi_az                = var.multi_az

  tags = {
    Name = "${var.rds_name}-rds"
  }
}