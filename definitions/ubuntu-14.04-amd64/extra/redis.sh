# From http://redis.io/topics/quickstart:
#
# The suggested way of installing Redis is compiling
# it from sources as Redis has no dependencies other
# than a working GCC compiler and libc. Installing it
# using the package manager of your Linux distribution
# is somewhat discouraged as usually the available
# version is not the latest.
#
# I wouldn't mind that, but the damn Ubuntu package
# redis-server doesn't come with Upstart init script,
# so there's no point in using that anyway.

wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make

update-rc.d redis-server disable

tee /etc/init/redis-server.conf <<-EOF
# From https://gist.github.com/bdotdub/714533.

# There's no config and neither we want one.
# If there will be any in the future, don't
# forget to make sure that daemonized is no.

# optional to run under the redis user
#setgid redis
#setuid redis

start on runlevel [23]
stop on shutdown

exec redis-server

respawn
EOF
