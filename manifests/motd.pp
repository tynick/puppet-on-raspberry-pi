# changes your motd to the contents of motd.txt in the files directory

file { '/etc/motd':
  source  => '/etc/puppet/code/environments/production/files/motd.txt',
}
