Veewee::Session.declare({
  cpu_count: '2', # Changed from 1.
  memory_size: '512',
  disk_size: '65536',
  disk_format: 'VDI',
  hostiocache: 'off',
  os_type_id: 'Ubuntu_64',
  iso_file: 'ubuntu-14.04-server-amd64.iso',
  iso_src: 'http://releases.ubuntu.com/14.04/ubuntu-14.04-server-amd64.iso',
  iso_md5: '01545fa976c8367b4f0d59169ac4866c',
  iso_download_timeout: '1000',
  boot_wait: '4',
  boot_cmd_sequence: [
    '<Esc><Esc><Enter>',
    '/install/vmlinuz noapic preseed/url=http://%IP%:%PORT%/preseed.cfg ',
    'debian-installer=en_US auto locale=en_US kbd-chooser/method=us ',
    'hostname=%NAME% ',
    'fb=false debconf/frontend=noninteractive ',
    'keyboard-configuration/modelcode=SKIP keyboard-configuration/layout=us keyboard-configuration/variant=us console-setup/ask_detect=false ',
    'initrd=/install/initrd.gz -- <Enter>'
],
  kickstart_port: '7122',
  kickstart_timeout: '10000',
  kickstart_file: 'preseed.cfg',
  ssh_login_timeout: '10000',

  # The default user we created in preseed.cfg.
  # Unfortunately we can't use root, as root doesn't
  # have any password nor SSH key at this point.
  ssh_user: 'vagrant',
  ssh_password: 'vagrant',
  ssh_key: '',
  ssh_host_port: '7222',
  ssh_guest_port: '22',
  sudo_cmd: "echo '%p'|sudo -S sh '%f'",
  shutdown_cmd: 'shutdown -P now',
  postinstall_files: [
   'base/build_time.sh',
   'base/apt.sh',
   'base/sudo.sh',
   'base/vagrant.sh',
   'base/git-n-curl.sh',
   'base/ruby.sh',
   'base/vbox.sh',
   'base/nfs.sh',
   'base/iptables.sh',

   'extra/nginx.sh',
   'extra/redis.sh',
   'extra/rabbitmq.sh',
   'extra/nodejs.sh',
   'extra/rubinius.sh',
   # 'extra/jruby.sh',
   'extra/monit.sh',
   'extra/convenience.sh',
   'extra/etc-git.sh',

   'base/cleanup.sh'
  ],
  postinstall_timeout: '10000'
})
