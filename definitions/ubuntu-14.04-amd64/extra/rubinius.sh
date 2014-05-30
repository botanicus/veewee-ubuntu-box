ruby-install rbx

RUBYBIN="$(echo /opt/rubies/rbx-*)/bin"
RUBYGEMSBIN="$(echo /opt/rubies/rbx-*)/gems/bin"

echo "PATH=$RUBYBIN:$RUBYGEMSBIN:\$PATH" | tee /etc/profile.d/rubinius.sh

# Bundler
. /etc/environment
. /etc/profile.d/rubinius.sh

gem install bundler
