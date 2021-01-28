#!/bin/bash

#!/bin/bash

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@     UPDATE REPOSITORY UBUNTU SERVER    @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
sudo apt-get update
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@        INSTALLATATION WEB SERVER       @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
sudo apt-get install -y nginx php-mysqli mysql-server php-fpm git unzip
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@           CONFIGRUATION NGINX          @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
sudo tee /etc/nginx/sites-available/pesbuk <<EOF
server {
        listen 80;
        root /var/www/html;
        # Add index.php to the list if you are using PHP
        index index.php index.html index.htm index.nginx-debian.html;
        server_name localhost;
        location / {
        	index index.php index.html index.htm;
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files \$uri \$uri/ =404;
        }
        location ~ \.php$ {
          include snippets/fastcgi-php.conf;
          fastcgi_pass unix:/run/php/php7.2-fpm.sock;
        }
}
EOF
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@       REMOVE ANY FILE IN LOCALHOST     @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
sudo rm -rf /var/www/html/*
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@        MOVE PROJECT TO LOCALHOST       @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
cd /var/www/html && sudo git clone https://github.com/hegiwibowo/sosial-media-master.git && sudo mv sosial-media-master-master/* .
#sudo sed -i 's/$db_host = "localhost";/$db_host = "192.168.56.200";/g' /var/www/html/config.php 
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@           CONFIGURATION NGINX          @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
sudo ln -s /etc/nginx/sites-available/pesbuk /etc/nginx/sites-enabled/pesbuk
sudo unlink /etc/nginx/sites-enabled/default
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@          RESTART NGINX AND PHP         @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl restart php7.2-fpm
#echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
#echo "@@@@@@@@@@@@@@@@@@@@          CONFIGURATION DATABASE        @@@@@@@@@@@@@@@@@@@@"
#echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
#cd /var/www/html/ 
#sudo mysql -u root << EOF
#CREATE DATABASE IF NOT EXISTS dbsosmed;
#CREATE USER IF NOT EXISTS 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';
#GRANT ALL PRIVILEGES ON * . * TO 'devopscilsy'@'localhost';
#FLUSH PRIVILEGES;
#EOF
#sudo mysql dbsosmed < dump.sql
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@     INSTALLATION WEB SERVER SUCCESS    @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@   PLEASE CHECK YOUR NGINX IN BROWSER   @@@@@@@@@@@@@@@@@@@@"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"