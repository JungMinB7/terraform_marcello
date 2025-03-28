variable "subnet_map" {
  type = any
  description = "Map of all subnets with AZ/type info"
}

variable "public_subnet_ids" {
  type = list(string)
  description = "Public subnet ID list"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "Private subnet ID list"
}

variable "public_subnet_az_map" {
  type = map(string)
  description = "AZ => public subnet ID"
}

variable "private_subnet_map" {
  type = map(object({
    subnet_id = string
    az        = string
  }))
  description = "private subnet info for routing"
}

# variable "certificate_arn" {
#   type = string
#   description = "ACM Certificate ARN"
# }

variable "key_name" {
  type = string
  description = "SSH key name"
}

variable "openvpn_ami_id" {
  type = string
}

variable "ec2_ami_id" {
  type = string
}

variable "rds_username" {
  description = "RDS username"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
}


# variable "user_data" {
#   type = string
#   description = "EC2 startup script"
# }
#

variable "sg_openvpn_ingress" {
  type = list(any)
  description = "Ingress rules for openvpn SG"
}

variable "sg_alb_ingress" {
  type = list(any)
  description = "Ingress rules for alb SG"
}

variable "sg_default_egress" {
  type = list(any)
  description = "Default egress rules"
}


#### db-ec2 사용시
# variable "db_ami_id" {
#   type        = string
#   description = "AMI ID for DB EC2 instance"
# }

# variable "db_user_data" {
#   type        = string
#   description = "User data script for DB EC2 setup"
# }

