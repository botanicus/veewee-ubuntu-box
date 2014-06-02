Veewee::Session.declare({
  cpu_count:   '1',
  memory_size: '2048',
  disk_size:   '10140',
  disk_format: 'VDI',
  hostiocache: 'off',
  os_type_id:  'Ubuntu_64',
  iso_file:    'ubuntu-13.04-server-amd64.iso',
  iso_src:     'http://releases.ubuntu.com/13.04/ubuntu-13.04-server-amd64.iso',
  iso_md5:     '4bd3270bde86d7e4e017e3847a4af485',
  iso_download_timeout: '1000',
  boot_wait: '4',
  boot_cmd_sequence: [
    '<Esc><Esc><Enter>',
    '/install/vmlinuz noapic preseed/url=http://%IP%:%PORT%/preseed.cfg ',
    'debian-installer=en_US auto locale=en_US kbd-chooser/method=us ',
    'hostname=vagrant ',
    'fb=false debconf/frontend=noninteractive ',
    'keyboard-configuration/modelcode=SKIP keyboard-configuration/layout=us keyboard-configuration/variant=us console-setup/ask_detect=false ',
    'initrd=/install/initrd.gz -- <Enter>'
],
  kickstart_port:      '7122',
  kickstart_timeout:   '10000',
  kickstart_file:      'preseed.cfg',
  ssh_login_timeout:   '10000',

  # The default user we created in preseed.cfg.
  # Unfortunately we can't use root, as root doesn't
  # have any password nor SSH key at this point.
  ssh_user:            'vagrant',
  ssh_password:        'vagrant',
  ssh_key:             '',
  ssh_host_port:       '7222',
  ssh_guest_port:      '22',
  sudo_cmd:            "echo '%p'|sudo -S sh '%f'",
  shutdown_cmd:        'shutdown -P now',
  postinstall_files:   ['../../../server/initial-setup.sh', 'postinstall.sh'],
  postinstall_timeout: '10000'
})