apt-get -y install nginx

cat > /etc/init/nginx.conf << EOF
# http://serverfault.com/questions/143461/how-can-i-start-nginx-via-upstart

# Note that environment variables don't expand in start and
# stop commands: http://upstart.ubuntu.com/cookbook/#restrictions
start on vagrant-mounted MOUNTPOINT="/vagrant"
stop on runlevel [!2345]

respawn

exec /usr/sbin/nginx -g "daemon off;"
EOF

update-rc.d nginx disable
