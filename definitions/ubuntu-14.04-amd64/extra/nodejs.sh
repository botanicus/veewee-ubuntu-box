# Alternative: https://github.com/creationix/nvm
wget http://nodejs.org/dist/v0.10.28/node-v0.10.28.tar.gz
tar xzf node-v0.10.28.tar.gz
cd node-v0.10.28
./configure --prefix=/opt/node-0.10.28 && make && make install

. /etc/profile.d/ruby.sh
ruby -pi -e 'sub(/"$/, ":/opt/node-0.10.28/bin\"")' /etc/environment
