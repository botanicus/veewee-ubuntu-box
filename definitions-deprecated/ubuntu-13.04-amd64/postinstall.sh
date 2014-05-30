#!/bin/sh

apt-get -y install linux-headers-$(uname -r)

# Installing the virtualbox guest additions
apt-get -y install dkms
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
mount -o loop VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

rm VBoxGuestAdditions_$VBOX_VERSION.iso

# Install NFS client
apt-get -y install nfs-common

# Setup sudo to allow no-password sudo for "admin"
# groupadd -r admin
# usermod -a -G admin vagrant
# cp /etc/sudoers /etc/sudoers.orig
# sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
# sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# Installing vagrant keys.
mkdir /root/.ssh
chmod 700 /root/.ssh
cd /root/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 /root/.ssh/authorized_keys

# Remove items used for building, since they aren't needed anymore
apt-get -y remove linux-headers-$(uname -r)
apt-get -y autoremove

apt-get clean

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp3/*

# Make sure Udev doesn't block our network
# http://6.ptmc.org/?p=164
echo "cleaning up udev rules"
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces
exit
