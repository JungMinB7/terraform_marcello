
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

# 퍼미션
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# ALB Health check용 index.html
echo "OK" > /var/www/html/index.html

# wp-config 설정
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# ✅ 실제 RDS 정보 반영
sed -i "s/database_name_here/wordpressdb/" /var/www/html/wp-config.php
sed -i "s/username_here/${db_username}/" /var/www/html/wp-config.php
sed -i "s/password_here/${db_password}/" /var/www/html/wp-config.php
sed -i "s/localhost/${db_endpoint}/" /var/www/html/wp-config.php

# Apache 재시작
systemctl restart httpd

###