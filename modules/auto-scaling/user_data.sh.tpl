# # 시스템 업데이트 및 패키지 설치
#!/bin/bash
yum update -y
amazon-linux-extras enable php8.0
sudo yum install -y httpd php php-gd php-mysqlnd wget unzip -y

# Apache 설정
sudo systemctl enable httpd
sudo systemctl start httpd

# WordPress 다운로드 및 설정
cd ~
wget http://wordpress.org/latest.tar.gz
# unzip latest.zip
tar xzvf latest.tar.gz
sudo rsync -avP ~/wordpress/ /var/www/html/
# cp -r wordpress/* .
# rm -rf wordpress latest.zip
mkdir /var/www/html/wp-content/uploads
# 퍼미션 설정
chown -R apache:apache /var/www/html/*
chmod -R 755 /var/www/html

# 임시 index.html로 ALB Health Check 통과
# echo "OK" > /var/www/html/index.html
cd /var/www/html
# wp-config.php 설정 자동화
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# db 연결
sed -i "s/database_name_here/wordpressdb/" /var/www/html/wp-config.php
sed -i "s/username_here/admin/" /var/www/html/wp-config.php
sed -i "s/password_here/mypassword/" /var/www/html/wp-config.php
sed -i "s/localhost/${db_private_ip}/" /var/www/html/wp-config.php

# Apache 재시작
systemctl restart httpd

