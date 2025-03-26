terraform {
 required_version = ">= 1.0.0, < 2.0.0"

  backend "s3" {
    bucket = "marcello-terraformstate"
    key  = "terraform/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    dynamodb_table = "marcello-terraformstate"
  }
}

module "vpc" {
  source      = "../modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "dev"
}

module "subnet" {
  source       = "../modules/subnet"
  vpc_id       = module.vpc.vpc_id
  subnet_name  = "subnet"
  environment  = "dev"
  subnet_map   = var.subnet_map
}

locals {
  public_subnet_ids = [
    module.subnet.subnet_ids["public-a-openvpn"],
    module.subnet.subnet_ids["public-b-alb"]
  ]

  private_subnet_ids = [
    module.subnet.subnet_ids["private-a"],
    module.subnet.subnet_ids["private-b"]
  ]

  public_subnet_az_map = {
    "ap-northeast-2a" = module.subnet.subnet_ids["public-a-openvpn"]
    "ap-northeast-2b" = module.subnet.subnet_ids["public-b-alb"]
  }

  private_subnet_map = {
    "private-a" = {
      subnet_id = module.subnet.subnet_ids["private-a"]
      az        = "ap-northeast-2a"
    },
    "private-b" = {
      subnet_id = module.subnet.subnet_ids["private-b"]
      az        = "ap-northeast-2b"
    }
  }
}

module "nat" {
  source                = "../modules/nat-gateway"
  vpc_id                = module.vpc.vpc_id
  nat_gateway_name      = "dev"
  public_subnet_az_map  = local.public_subnet_az_map
  private_subnet_map    = local.private_subnet_map
}

module "igw" {
  source             = "../modules/internet-gateway"
  vpc_id             = module.vpc.vpc_id
  internet_gateway_name = "dev"
  public_subnet_ids  = local.public_subnet_ids
}

module "sg_openvpn" {
  source       = "../modules/security-group"
  security_group_name = "openvpn-sg"
  name_prefix   = "dev"
  description  = "Allow SSH and OpenVPN"
  vpc_id       = module.vpc.vpc_id
  ingress_rules = var.sg_openvpn_ingress
  egress_rules  = var.sg_default_egress
}

module "openvpn" {
  source             = "../modules/openvpn"
  openvpn_name        = "dev"
  ami_id             = var.openvpn_ami_id
  instance_type      = "t3.micro"
  key_name           = var.key_name
  subnet_id          = module.subnet.subnet_ids["public-a-openvpn"]
  security_group_id  = module.sg_openvpn.security_group_id
}

module "sg_alb" {
  source       = "../modules/security-group"
  security_group_name =  "sg_alb"
  name_prefix   = "alb"
  description  = "Allow HTTP/HTTPS"
  vpc_id       = module.vpc.vpc_id
  ingress_rules = var.sg_alb_ingress
  egress_rules  = var.sg_default_egress
}

module "alb" {
  source             = "../modules/alb"
  alb_name           = "dev"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = local.public_subnet_ids
  security_group_id  = module.sg_alb.security_group_id
  target_port        = 443
  # certificate_arn    = var.certificate_arn
}

module "sg_ec2" {
  source       = "../modules/security-group"
  security_group_name = "ec2-sg"
  name_prefix = "dev"
  description  = "Allow from ALB"
  vpc_id       = module.vpc.vpc_id
  ingress_rules = [
    {
      description     = "Allow from ALB"
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      security_groups = [module.sg_alb.security_group_id]
    },
    {  
      description     = "Allow HTTPS from ALB"
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      security_groups = [module.sg_alb.security_group_id]
  }
  ]
  egress_rules = [
    {
        description = "DB access"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["10.0.0.0/16"]  # VPC 범위
    }
  ]

}

module "auto-scaling" {
  source              = "../modules/auto-scaling"
  autoscaling_group_name = "dev"
  launch_template_name = "service"
  ami_id              = var.ec2_ami_id
  instance_type       = "t3.micro"
  key_name            = var.key_name
  subnet_ids          = local.private_subnet_ids
  security_group_id   = module.sg_ec2.security_group_id
  target_group_arns   = [module.alb.target_group_arn]
  desired_capacity    = 2
  min_size            = 1
  max_size            = 3
  user_data           = var.user_data
}

module "sg_db" {
  source       = "../modules/security-group"
  name_prefix  = "dev"
  security_group_name = "db"
  description  = "Allow MySQL from EC2"
  vpc_id       = module.vpc.vpc_id
  ingress_rules = [
    {
      description     = "Allow MySQL"
      from_port       = 3306
      to_port         = 3306
      protocol        = "tcp"
      security_groups = [module.sg_ec2.security_group_id]
    }
  ]
  egress_rules = var.sg_default_egress
}

module "db" {
  source            = "../modules/db-ec2"
  name_prefix       = "dev"
  ami_id            = var.db_ami_id
  instance_type     = "t3.micro"
  key_name          = var.key_name
  subnet_id         = module.subnet.subnet_ids["db-a"]
  security_group_id = module.sg_db.security_group_id
  user_data         = var.db_user_data
}