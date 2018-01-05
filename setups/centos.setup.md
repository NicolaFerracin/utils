# CentOS 7

## System Update
yum update

## Create admin user
useradd admin
passwd admin

## Install nginx
yum install epel-release
yum install nginx
nginx -t
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
systemctl start nginx
mkdir /etc/nginx/sites-enabled
mkdir /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/grav /etc/nginx/sites-enabled/grav

## Install and setup git
yum install git

## PHP setup
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install yum-utils
yum-config-manager --enable remi-php56
yum update


## Grav setup
yum install composer
# update nginx.conf



## Node app setup
curl -sL https://rpm.nodesource.com/setup_8.x | bash -
yum install nodejs
