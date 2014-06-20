ruby-install jruby

RUBYBIN="$(echo /opt/rubies/jruby-*)/bin"

echo "PATH=$RUBYBIN:\$PATH" | tee /etc/profile.d/jruby.sh

# Bundler
. /etc/environment
. /etc/profile.d/jruby.sh

gem install bundler
