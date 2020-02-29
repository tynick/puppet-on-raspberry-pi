# make sure out puppet directory exists
file { '/etc/puppet/code/environments/production/':
  ensure  => directory,
}
