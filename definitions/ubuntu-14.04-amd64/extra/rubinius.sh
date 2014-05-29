ruby-install rbx
RUBYBIN=/opt/rubies/rbx-*/bin
echo "PATH=$RUBYBIN:$PATH" | tee /etc/profile.d/rubinius.sh

# Bundler
$RUBYBIN/gem install bundler
