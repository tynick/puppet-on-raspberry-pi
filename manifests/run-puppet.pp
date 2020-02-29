# put our run-puppet script in /usr/local/bin with execute permissions
file { '/usr/local/bin/run-puppet':
  source => '/etc/puppet/code/environments/production/files/run-puppet.sh',
  mode   => '0755',
}

# make a cron job to execute our run-puppet script every 15 minutes
cron { 'run-puppet':
  command => '/usr/local/bin/run-puppet',
  hour    => '*',
  minute  => '*/15',
}
