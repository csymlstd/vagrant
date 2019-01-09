#!/bin/sh
sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
echo 'Importing Bowtie DB'
mysql --login-path=local -e "DROP DATABASE IF EXISTS wordpress"
mysql --login-path=local -e "CREATE DATABASE wordpress"
mysql --login-path=local wordpress < /var/www/bowtie-wordpress.sql
rm -f /var/www/bowtie-wordpress.sql
echo "Generating self-signed SSL certificate"
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048  -subj "/CN=$1.test" -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt  > /dev/null 2>&1
echo "Generating strong Diffie-Hellman group parameters. This will take a while..."
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 > /dev/null 2>&1
echo "Restarting NGINX"
sudo systemctl restart nginx
echo "🎉  Now serving Wordpress on $1.test"
echo "🔒  HTTPS is available"
echo "🗄  Go to $1.test:8080 to manage the DB"
exit 0