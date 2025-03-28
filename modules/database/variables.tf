variable "rds_name" {
  description = "RDS identifier name"
  type        = string
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "username" {
  type    = string
  default = "admin"
}

variable "password" {
  type    = string
}

variable "port" {
  type    = number
  default = 3306
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "security_group_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}