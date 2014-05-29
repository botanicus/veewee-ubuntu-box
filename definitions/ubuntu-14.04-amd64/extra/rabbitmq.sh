# RabbitMQ.

cat > /etc/apt/sources.list.d/rabbitmq.list << EOF
deb http://www.rabbitmq.com/debian/ testing main
EOF

wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc
rm rabbitmq-signing-key-public.asc

apt-get update
apt-get install -y rabbitmq-server
