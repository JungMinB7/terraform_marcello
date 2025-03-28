# # # # 시스템 업데이트 및 패키지 설치
# # #!/bin/bash
# # yum update -y
# # amazon-linux-extras enable php8.0
# # sudo yum install -y httpd php php-gd php-mysqlnd wget unzip -y

# # # Apache 설정
# # sudo systemctl enable httpd
# # sudo systemctl start httpd

# # # WordPress 다운로드 및 설정
# # cd ~
# # wget http://wordpress.org/latest.tar.gz
# # # unzip latest.zip
# # tar xzvf latest.tar.gz
# # sudo rsync -avP ~/wordpress/ /var/www/html/
# # # cp -r wordpress/* .
# # # rm -rf wordpress latest.zip
# # mkdir /var/www/html/wp-content/uploads
# # # 퍼미션 설정
# # chown -R apache:apache /var/www/html/*
# # chmod -R 755 /var/www/html

# # # 임시 index.html로 ALB Health Check 통과
# # # echo "OK" > /var/www/html/index.html
# # cd /var/www/html


# sudo yum -y install httpd wget php
# sudo systemctl start httpd
# sudo systemctl enable httpd
# cd ~/
# wget http://wordpress.org/latest.tar.gz
# tar -xzf latest.tar.gz
# cd wordpress
# cp wp-config-sample.php wp-config.php
# sudo cp -r ./* /var/www/html
# chown -R apache:apache /var/www/html
# chmod -R 755 /var/www/html

# # wp-config.php 설정 자동화
# # cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# # db 연결
# sed -i "s/database_name_here/wordpressdb/" /var/www/html/wp-config.php
# sed -i "s/username_here/admin/" /var/www/html/wp-config.php
# sed -i "s/password_here/mypassword/" /var/www/html/wp-config.php
# sed -i "s/localhost/${db_private_ip}/" /var/www/html/wp-config.php

# # Apache 재시작
# systemctl restart httpd

################################ 3월 28일 주석처리
# #!/bin/bash
# yum update -y
# amazon-linux-extras enable php8.0
# yum install -y httpd php php-mysqlnd wget unzip -y

# systemctl enable httpd
# systemctl start httpd

# cd /tmp
# wget https://wordpress.org/latest.tar.gz
# tar -xzf latest.tar.gz
# cp -r wordpress/* /var/www/html/

# chown -R apache:apache /var/www/html
# chmod -R 755 /var/www/html

# # 워드프레스 설정
# cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# sed -i "s/database_name_here/wordpressdb/" /var/www/html/wp-config.php
# sed -i "s/username_here/admin/" /var/www/html/wp-config.php
# sed -i "s/password_here/mypassword/" /var/www/html/wp-config.php
# sed -i "s/localhost/${db_private_ip}/" /var/www/html/wp-config.php

# # Health check 통과용 index.html
# echo "OK" > /var/www/html/index.html

# systemctl restart httpd
####################################

#!/bin/bash
# 시스템 업데이트 및 웹서버 구성
yum update -y
amazon-linux-extras enable php8.0
yum install -y httpd php php-mysqlnd wget unzip -y

# Apache 시작 및 부팅 시 자동 실행
systemctl enable httpd
systemctl start httpd

# 워드프레스 설치
cd /var/www/html
wget https://wordpress.org/latest.zip
unzip latest.zip
cp -r wordpress/* .
rm -rf wordpress latest.zip

# 퍼미션 설정
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# ALB Health Check 통과용
echo "OK" > /var/www/html/index.html

# wp-config.php 설정
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# 💡 RDS의 엔드포인트를 정확히 입력
sed -i "s/database_name_here/wordpressdb/" /var/www/html/wp-config.php
sed -i "s/username_here/admin/" /var/www/html/wp-config.php
sed -i "s/password_here/mypassword/" /var/www/html/wp-config.php
sed -i "s/localhost/${db_endpoint}/" /var/www/html/wp-config.php

# Apache 재시작
systemctl restart httpd
