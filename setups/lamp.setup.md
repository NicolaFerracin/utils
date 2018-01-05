# LAMP, DEBIAN

## System Update
apt-get update

## Create admin user
useradd admin
passwd admin

## Install and setup git
apt-get install git

## Grav setup (NOT NEEEDED)
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
/etc/apache2/apache2.conf -> AlloRedirect All // for Directory and Directory /var/www
a2enmod proxy proxy_fcgi rewrite
service apache2 restart

## Set up apache (ONCE FOR EVERY PROJECT)
chown -R www-data: /var/www/WEBSITE
cp /etc/apache2/sites-available/default.conf /etc/apache2/sites-available/WEBSITE.conf
## Edit /WEBSITE.conf
a2ensite WEBSITE.conf
service apache2 reload

# Let's encrypt (ONCE FOR EVERY PROJECT)
cd /opt
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
./opt/certbot-auto --apache

# Node app setup
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs
apt-get install build-essential -y
npm i -g pm2
pm2 start INDEX.JS --name WEBSITE
pm2 startup systemd // restart on server reboot
## Apache for Node
a2enmod proxy
a2enmod proxy_http
service apache2 restart


## Install wp-cli

# Download
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# check
php wp-cli.phar --info
# set rights
chmod +x wp-cli.phar
# move
sudo mv wp-cli.phar /usr/local/bin/wp
