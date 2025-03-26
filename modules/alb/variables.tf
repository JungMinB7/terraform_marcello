# variable "certificate_arn" {
#   description = "ARN of the ACM certificate for HTTPS listener"
#   type        = string
# }

variable "alb_name" {
  description = "Prefix for naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "ALB security group ID"
  type        = string
}

variable "target_port" {
  description = "Port on which targets (e.g. EC2) listen"
  type        = number
  default     = 80
}
