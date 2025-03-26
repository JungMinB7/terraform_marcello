variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of DB subnet IDs (usually in 2 AZs)"
}

variable "security_group_id" {
  type        = string
  description = "Security group for RDS"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "username" {
  type        = string
  description = "Master username"
}

variable "password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "engine" {
  type        = string
  description = "Database engine (e.g., mysql, postgres)"
  default     = "mysql"
}

variable "engine_version" {
  type        = string
  description = "DB engine version"
  default     = "8.0"
}

variable "instance_class" {
  type        = string
  description = "RDS instance type"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage (GB)"
  default     = 20
}

variable "port" {
  type        = number
  description = "Port to listen on"
  default     = 3306
}

variable "multi_az" {
  type        = bool
  description = "Whether to enable Multi-AZ"
  default     = false
}