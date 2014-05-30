apt-get -y autoremove

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

echo "cleaning up udev rules"
rm -f /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "don't leave any mess"
rm -rf ~/* /home/vagrant/*

echo "we don't need the Ubuntu Ruby"
apt-get -y remove ruby

echo "pre-up sleep 2" >> /etc/network/interfaces
exit
