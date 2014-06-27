apt-get -y install vim

# ZSH.
apt-get install -y zsh

chsh -s /bin/zsh # root
chsh -s /bin/zsh vagrant

# Ack
# The Ubuntu package is out of date and the binary is called ack-grep which is terribly confusing.
# apt-get install -y ack-grep
curl http://beyondgrep.com/ack-2.04-single-file > /usr/bin/ack && chmod 0755 /usr/bin/ack

npm install -g bower uglify-js uglifycss
