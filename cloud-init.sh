#!/bin/bash

# Update all installed packages
yum update -y

# Install Apache
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Install MariaDB 10.5 and PHP with necessary modules
yum install -y mariadb105-server php php-mysqlnd
systemctl start mariadb
systemctl enable mariadb

# Remove Apache's default "It works!" page
rm -f /var/www/html/index.html

# Download and set up WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/* ./
rm -rf wordpress latest.tar.gz

# Set permissions for Apache to access WordPress files
chown -R apache:apache /var/www/html/
chmod -R 755 /var/www/html/

# Restart Apache to ensure changes are applied
systemctl restart httpd