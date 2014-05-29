# Install ruby-install.
wget -O ruby-install-0.4.3.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz
tar -xzvf ruby-install-0.4.3.tar.gz
cd ruby-install-0.4.3/
make install
rm -rf ruby-install-0.4.3 ruby-install-0.4.3.tar.gz

# Install MRI.
ruby-install ruby

RUBYBIN=/opt/rubies/ruby-*/bin
echo "PATH=$RUBYBIN:$PATH" | tee /etc/profile.d/ruby.sh

# No RDoc, no RI.
echo "gem: --no-ri --no-rdoc" | tee ~/.gemrc

# Bundler.
$RUBYBIN/gem install bundler
