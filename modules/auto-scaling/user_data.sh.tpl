# # 시스템 업데이트 및 패키지 설치
#!/bin/bash
yum update -y
amazon-linux-extras enable php8.0
yum install -y httpd php php-mysqlnd wget unzip -y

# Apache 설정
systemctl enable httpd
systemctl start httpd

# WordPress 다운로드 및 설정
cd /var/www/html
wget https://wordpress.org/latest.zip
unzip latest.zip
cp -r wordpress/* .
rm -rf wordpress latest.zip

# 퍼미션 설정
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# 임시 index.html로 ALB Health Check 통과
# echo "OK" > /var/www/html/index.html

# wp-config.php 설정 자동화
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/wordpressdb/" /var/www/html/wp-config.php
sed -i "s/username_here/admin/" /var/www/html/wp-config.php
sed -i "s/password_here/mypassword/" /var/www/html/wp-config.php
sed -i "s/localhost/${db_private_ip}/" /var/www/html/wp-config.php

# Apache 재시작
systemctl restart httpd

