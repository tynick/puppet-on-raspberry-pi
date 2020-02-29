# add packages you want on your Raspberry Pi

package { 'vim':
  ensure => installed,
}

package { 'git':
  ensure => installed,
}

package { 'python3-pip':
  ensure => installed,
}
