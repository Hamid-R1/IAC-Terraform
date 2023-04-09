#!/bin/bash

# System Updates
sudo su -
yum -y update

# Install Apache Web Server
yum install -y httpd

# Start & enable Apache Web Server
systemctl start httpd
systemctl enable httpd

# Install git & clone 'html-css-js-code' from github
yum install -y git
mkdir source-code
cd source-code
git clone https://github.com/Hamid-R1/basic_profile_website.git

# Configure & setup 'Application' to this path '/var/www/html/'
cd basic_profile_website/DevFolio/
cp -r * /var/www/html/