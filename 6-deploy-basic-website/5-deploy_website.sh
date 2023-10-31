#!/bin/bash

# System Updates
sudo yum -y update

# Install Apache Web Server
sudo yum install -y httpd

# Start & enable Apache Web Server
sudo systemctl start httpd
sudo systemctl enable httpd

# Install git & clone 'html-css-js-code' from github
sudo yum install -y git
mkdir source-code
cd source-code
sudo git clone https://github.com/Hamid-R1/basic_profile_website.git

# Configure & setup 'Application' to this path '/var/www/html/'
cd basic_profile_website/DevFolio/
sudo cp -r * /var/www/html/
