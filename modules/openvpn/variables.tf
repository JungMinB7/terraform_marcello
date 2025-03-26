variable "ami_id" {
  description = "AMI ID for the OpenVPN instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the OpenVPN instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for OpenVPN instance"
  type        = string
}

variable "key_name" {
  description = "SSH Key name to access instance"
  type        = string
}

variable "openvpn_name" {
  description = "Prefix for resource naming"
  type        = string
}
