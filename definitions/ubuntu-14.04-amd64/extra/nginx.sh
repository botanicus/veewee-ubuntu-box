apt-get -y install nginx

cat > /etc/init/nginx.conf << EOF
# http://serverfault.com/questions/143461/how-can-i-start-nginx-via-upstart
description "Nginx HTTP Server"

start on vagrant-mounted
stop on runlevel [!2345]

respawn

exec /usr/sbin/nginx -g "daemon off;"
EOF
