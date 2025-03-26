variable "ami_id" {
  type        = string
  description = "AMI ID for DB EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for DB EC2"
}

variable "security_group_id" {
  type        = string
  description = "SG for DB EC2"
}

variable "key_name" {
  type        = string
  description = "SSH key name"
}

variable "name_prefix" {
  type        = string
}

variable "user_data" {
  type        = string
  description = "User data to install DB (e.g. MariaDB)"
}