#!/bin/sh

# Without this our Redis clan be wiped out and so can be our RabbitMQ.
# redis-cli -h the.host FLUSHDB # Whops, sorry bro ...

# This can be fixed in two ways:
# Change redis.conf: bind 127.0.0.1 -> bind 0.0.0.0
# There's a solution for RabbitMQ as well:
# http://serverfault.com/questions/235669/how-do-i-make-rabbitmq-listen-only-to-localhost
#
# What if I want to allow multiple IPs though?
# And besides, sooner or later I'm going to write
# some iptables rules anyway, so I might as well
# start right now.
#
# Besides with iptables I don't have to figure out
# how to do it for every other service I install.
#
# Alright, ready?

# TODO:
# Connection limit and rate limit. You want your firewall to be able to slow things down in the event of a DDoS attack or repeated attempts at port-knocking or things like that.
# Block all unnecessary out-going traffic. This can help in case your machine is compromised as most bots need to connect to a remote command-and-control server.
# Block all other incoming ports. You should really still block everything else, just in case an attacker manages to install some app and opens up a back-door port.
# Deny SSH connection after 4 unsuccessful tries http://blog.bigdinosaur.org/securing-ssh-with-iptables/

tee /etc/init/load_iptables_rules.conf <<EOF
start on runlevel 2

script
  # It uses sudo, because it's for Vagrant ...

  # Flush all rules in the default table (filter).
  sudo iptables -F

  sudo iptables -P INPUT DROP
  sudo iptables -A INPUT -i lo -p all -j ACCEPT
  sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
  sudo iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
  sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
  sudo iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
  sudo iptables -A INPUT -j DROP
end script
EOF

# NOTES:
#
# Port forwarding:
# iptables -t nat -A PREROUTING -i $EXT_IF -p tcp -m tcp --dport 443 -j REDIRECT --to-ports 8443
#
# List:
# sudo iptables -t filter --list
