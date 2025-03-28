# AWS 기본 설정
key_name        = "keypair-for-terraform"
# certificate_arn = "arn:aws:acm:ap-northeast-2:123456789012:certificate/your-cert-id"

# AMI 설정
openvpn_ami_id  = "ami-09a093fa2e3bfca5a" ##openvpn
ec2_ami_id      = "ami-062cddb9d94dcf95d" ## amazon linux
# db_ami_id       = "ami-062cddb9d94dcf95d" ## amazon linux

# 보안 그룹 규칙
sg_openvpn_ingress = [
  {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "OpenVPN"
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

sg_alb_ingress = [
  {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

sg_default_egress = [
  {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

# user_data 스크립트 예시
# user_data = <<-EOF
# #!/bin/bash
# yum update -y


# amazon-linux-extras enable php8.0
# #yum install -y httpd php php-mysqlnd wget unzip mod_ssl -y
# yum install -y httpd php php-mysqlnd wget unzip -y


# systemctl enable httpd
# systemctl start httpd


# cd /var/www/html
# wget https://wordpress.org/latest.zip
# unzip latest.zip
# cp -r wordpress/* .
# rm -rf wordpress latest.zip

# chown -R apache:apache /var/www/html
# chmod -R 755 /var/www/html


# # mkdir -p /etc/ssl/selfsigned
# # cd /etc/ssl/selfsigned
# # openssl req -x509 -nodes -days 365 \
# #   -newkey rsa:2048 \
# #   -keyout selfsigned.key \
# #   -out selfsigned.crt \
# #   -subj "/C=KR/ST=Seoul/L=Gangnam/O=MyOrg/CN=localhost"


# # cat > /etc/httpd/conf.d/ssl.conf <<EOL
# # <VirtualHost *:443>
# #     DocumentRoot "/var/www/html"
# #     ServerName localhost

# #     SSLEngine on
# #     SSLCertificateFile /etc/ssl/selfsigned/selfsigned.crt
# #     SSLCertificateKeyFile /etc/ssl/selfsigned/selfsigned.key

# #     <Directory "/var/www/html">
# #         AllowOverride All
# #         Require all granted
# #     </Directory>
# # </VirtualHost>
# EOL


# # systemctl restart httpd


# cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# sed -i "s/database_name_here/wordpressdb/" /var/www/html/wp-config.php
# sed -i "s/username_here/admin/" /var/www/html/wp-config.php
# sed -i "s/password_here/mypassword/" /var/www/html/wp-config.php
# sed -i "s/localhost/10.0.5.100/" /var/www/html/wp-config.php 

# echo "OK" > /var/www/html/index.html   #healthy check 

# systemctl restart httpd

# EOF


# db_user_data = <<-EOF
# #!/bin/bash
# sudo yum update -y
# sudo yum install -y mariadb-server

# sudo systemctl start mariadb
# sudo systemctl enable mariadb


# sed -i 's/^bind-address=.*/bind-address=0.0.0.0/' /etc/my.cnf


# mysql -u root <<EOFSQL
# CREATE DATABASE wordpressdb;
# CREATE USER 'admin'@'%' IDENTIFIED BY 'mypassword';
# GRANT ALL PRIVILEGES ON wordpressdb.* TO 'admin'@'%';
# FLUSH PRIVILEGES;
# EOFSQL


# systemctl restart mariadb
# EOF


rds_username = "admin"
rds_password = "mypassword"


# 서브넷 설정 예시
subnet_map = {
  "public-a-openvpn" = {
    cidr_block       = "10.0.1.0/24"
    az               = "ap-northeast-2a"
    type             = "public"
    assign_public_ip = false
  },
  "public-b-alb" = {
    cidr_block       = "10.0.2.0/24"
    az               = "ap-northeast-2b"
    type             = "public"
    assign_public_ip = true
  },
  "private-a" = {
    cidr_block = "10.0.3.0/24"
    az         = "ap-northeast-2a"
    type       = "private"
  },
  "private-b" = {
    cidr_block = "10.0.4.0/24"
    az         = "ap-northeast-2b"
    type       = "private"
  },
  "db-a" = {
    cidr_block = "10.0.5.0/24"
    az         = "ap-northeast-2a"
    type       = "db"
  },
  "db-b" = {
    cidr_block = "10.0.6.0/24"
    az         = "ap-northeast-2b"
    type       = "db"
  }
}

# public_subnet_az_map = {
#   "ap-northeast-2a" = "subnet-0aaa"
#   "ap-northeast-2b" = "subnet-0bbb"
# }

# private_subnet_map = {
#   "private-a" = {
#     subnet_id = "subnet-0ccc"
#     az        = "ap-northeast-2a"
#   },
#   "private-b" = {
#     subnet_id = "subnet-0ddd"
#     az        = "ap-northeast-2b"
#   }
# }

# public_subnet_ids = [
#   {
#   "ap-northeast-2a" = module.subnet.subnet_ids["public-a-openvpn"],
#   "ap-northeast-2b" = module.subnet.subnet_ids["public-b-alb"]
#   }
# ]


# private_subnet_map = {
#   "private-a" = {
#     subnet_id = module.subnet.subnet_ids["private-a"]
#     az        = "ap-northeast-2a"
#   }
# }

# ✅ 빈 배열로 초기화 (subnet_ids는 apply 이후 모듈 output으로 주입 필요)
public_subnet_ids  = []
private_subnet_ids = []

# ✅ AZ 매핑 구조 보완 (초기화 형태)
public_subnet_az_map = {
  "ap-northeast-2a" = ""
  "ap-northeast-2b" = ""
}

private_subnet_map = {
  "private-a" = {
    subnet_id = ""
    az        = "ap-northeast-2a"
  },
  "private-b" = {
    subnet_id = ""
    az        = "ap-northeast-2b"
  }
}