#!/bin/sh

# Hack for Veewee/Vagrant.
export HOME=/root

echo "=== Environment ==="
echo "USER: $USER"
echo "HOME: $HOME"

# Apt-install various things necessary for Ruby, guest additions,
# etc., and remove optional things to trim down the machine.
apt-get -y update
apt-get -y upgrade
apt-get -y install build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev libyaml-dev
apt-get -y install vim curl
apt-get -y install git-core

# Locale
# I hope this will solve issues like
# http://askubuntu.com/questions/17001/how-to-set-locale
sudo apt-get install language-pack-en-base
sudo dpkg-reconfigure locales

# Nginx
apt-get -y install nginx
cat > /etc/init/nginx.conf << EOF
# http://serverfault.com/questions/143461/how-can-i-start-nginx-via-upstart
description "Nginx HTTP Server"

start on filesystem
stop on runlevel [!2345]

respawn

exec /usr/sbin/nginx -g "daemon off;"
EOF

# Install Ruby
git clone git://github.com/sstephenson/ruby-build.git /opt/ruby-build
/opt/ruby-build/bin/ruby-build 1.9.3-p392 /opt/ruby-1.9.3-p392

# Set up $PATH
paths=$(ls /opt | awk '{ printf "/opt/%s/bin:", $0 }')
chars=$(echo $paths | wc -c)
index=$(expr $chars - 2)
optbins=$(echo $paths | cut -c -$index)
export PATH=$optbins:$PATH

# Save $PATH.
echo "PATH=$optbins:$PATH" > /etc/environment

# Bundler.
gem install bundler --no-rdoc --no-ri

# ZSH
apt-get install -y zsh
chsh -s /bin/zsh

# Dotfiles
curl https://raw.github.com/botanicus/dotfiles/master/install.rb | ruby

# Ack
# The Ubuntu package is out of date and the binary is called ack-grep which is terribly confusing.
# apt-get install -y ack-grep
curl http://beyondgrep.com/ack-2.04-single-file > /usr/bin/ack && chmod 0755 /usr/bin/ack
