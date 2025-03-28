#!/bin/bash
set -e

# 패키지 업데이트 및 설치
dnf update -y
dnf install -y php php-mysqlnd httpd wget unzip ## tar gzip

# Apache 설정
systemctl enable httpd
systemctl start httpd

# WordPress 다운로드 및 압축해제 (tar.gz 사용 가능하지만 unzip도 문제 없음)
cd /var/www/html
wget https://wordpress.org/latest.zip
unzip latest.zip
cp -r wordpress/* .
rm -rf wordpress latest.zip

# 퍼미션 설정
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html


# wp-config 설정
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/wordpressdb/" wp-config.php
sed -i "s/username_here/${db_username}/" wp-config.php
sed -i "s/password_here/${db_password}/" wp-config.php
sed -i "s/localhost/${db_endpoint}/" wp-config.php

# Apache 재시작
systemctl restart httpd