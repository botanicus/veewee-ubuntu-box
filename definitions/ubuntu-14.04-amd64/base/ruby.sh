# Install ruby-install.

# Problem with this motherfucker is that it doesn't have
# any means to update itself at least as far as I can tell.
# So first things first, let's at least use HEAD and later
# TODO: figure out if I can just clone it to /opt and add
# it to path and use it straight away.

git clone https://github.com/postmodern/ruby-install.git
cd ruby-install
make install

# Install MRI.
ruby-install ruby -- --disable-install-doc

RUBYBIN="$(echo /opt/rubies/ruby-*)/bin"
echo "PATH=$RUBYBIN:\$PATH" | tee /etc/profile.d/ruby.sh

# No RDoc, no RI.
echo "gem: --no-ri --no-rdoc" | tee ~/.gemrc

# Bundler.
. /etc/environment
. /etc/profile.d/ruby.sh

gem install bundler
