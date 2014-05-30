# RabbitMQ.

cat > /etc/apt/sources.list.d/rabbitmq.list << EOF
deb http://www.rabbitmq.com/debian/ testing main
EOF

wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc
rm rabbitmq-signing-key-public.asc

apt-get install -y rabbitmq-server

update-rc.d rabbitmq-server disable

tee /etc/init/rabbitmq-server.conf <<EOF
description "RabbitMQ Server"
author  "RabbitMQ"

start on runlevel [2345]
stop on runlevel [016]
respawn

exec /usr/sbin/rabbitmq-server > /var/log/rabbitmq/startup_log \
                              2> /var/log/rabbitmq/startup_err
post-start exec /usr/sbin/rabbitmqctl wait >/dev/null 2>&1
EOF
