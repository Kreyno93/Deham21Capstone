#!/bin/bash

# Installation of Wordpress on Amazon Linux 2023

# Update the system
sudo dnf update -y
# Install necessary packages
sudo dnf install -y httpd mariadb105-server php php-mysqlnd php-fpm php-xml php-mbstring wget
# Start and enable Apache and MariaDB
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start mariadb
sudo systemctl enable mariadb
# Secure MariaDB installation
sudo mysql_secure_installation <<EOF
y
y
y
y
y
EOF
# Create a database and user for WordPress
DB_NAME="wordpress"
DB_USER="wordpressuser"
DB_PASS="password"
sudo mysql -u root -p <<EOF
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EOF

# Download and extract WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo mv wordpress/* /var/www/html/
# Set permissions
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/
# Configure WordPress
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
sudo sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php
sudo sed -i "s/password_here/$DB_PASS/" /var/www/html/wp-config.php
# Restart Apache
sudo systemctl restart httpd
# Enable Apache to start on boot
sudo systemctl enable httpd
