#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y nginx php-mysqli mysql-server php-fpm git unzip
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
sudo rm -rf /var/www/html/*
cd /var/www/html
sudo git clone https://github.com/sdcilsy/sosial-media.git
cd sosial-media
sudo mv * ../
sudo ln -s /etc/nginx/sites-available/pesbuk /etc/nginx/sites-enabled/pesbuk
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl restart nginx.service
sudo systemctl restart php7.2-fpm


