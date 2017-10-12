#!/bin/bash

apt-get update
export DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
apt-get install -y ${application}
mv /var/www/html/index.html /var/www/html/index_old.html
echo "<html>" > /var/www/html/index.html
echo "hostname: $(cat /etc/hostname)" >> /var/www/html/index.html
echo "</html>" >> /var/www/html/index.html

