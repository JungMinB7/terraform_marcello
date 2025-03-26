variable "launch_template_name" {
  description = "Prefix for naming"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for EC2 instances"
  type        = string
}

variable "autoscaling_group_name" {
  description = "Prefix for naming"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "target_group_arns" {
  description = "ALB target group ARNs to attach"
  type        = list(string)
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of instances"
  default     = 2
}

variable "min_size" {
  type        = number
  description = "Minimum number of instances"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances"
  default     = 3
}

variable "user_data" {
  description = "Startup script (bash)"
  type        = string
  default     = ""
}
