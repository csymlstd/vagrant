#!/bin/sh
sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile
echo "Generating self-signed SSL certificate"
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048  -subj "/CN=$1.test" -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt  > /dev/null 2>&1
echo "Generating strong Diffie-Hellman group parameters. This will take a while..."
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048 > /dev/null 2>&1
echo "Restarting NGINX"
sudo systemctl restart nginx
echo "🎉  Now serving /var/www/html on $1.test"
echo "🔒  HTTPS is available"
echo "🗄  Go to phpmyadmin.$1.test to manage the DB"
exit 0