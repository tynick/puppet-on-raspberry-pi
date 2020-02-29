# create users and add keys
# change these variables

# name of new user
$myuser = 'tynick'

# password for new user
# openssl passwd -1
# ^ run that command to generate a password hash for this
$password = '$1$WQwBaqqF$4Fi8e9o.poBsUt..v4U6X0'

# your ssh public key. used for passwordless login
# ONLY INCLUDE THE LONG STRING IN THE MIDDLE
$ssh_key = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDDM+o6O89pVdVl0zz7WxMYrOWiGezBwKnaBHvuDju3c30dbkuRJPs5ShCIWmh1UIFNGffx437SzxlN2V6KL20rDc/LQ31TcPBQ9BdD+jGMB9ygFtH2Nsi2Uem4M2y0Vw83KEoPtGUGnqZwRdu1/SVt1z2FxeOlTXvdT78zZIrqDO69o0Wz56wg4TXFef8TDKe3QHs/c6GxnH6b9vrKhtVAyu/jrLphxXWkF/cY9OdsePr2ScGyfprYx0I6QgfZMH9OHSr4usfuoMTYP9OLtHQ8cVI9vq/4cHgmd3hnDWNik8Yv1QJSIHpyMASVY3Zsun3br/UHhD9GbS87BM0NEM3J'

# create group
group { "create_${myuser}_group":
  name    => $myuser,
  gid     => '3002',
}

# create user and set password
user { "create_${myuser}_user":
  name        => $myuser,
  password    => $password,
  uid         => '3002',
  gid         => '3002',
  ensure      => present,
  managehome  => true,
  groups      => 'sudo',
  shell       => '/bin/bash',
  require     => Group[$myuser],
}


# allow no passwd sudo for user
file { "/etc/sudoers.d/010_${myuser}-nopasswd":
  ensure   => present,
  mode     => '0440',
  content  => "${myuser} ALL=(ALL) NOPASSWD: ALL",
  require  => User[$myuser],
}

# add ssh key for user
ssh_authorized_key { "${myuser}-public-key":
  ensure  => present,
  user    => $myuser,
  type    => 'ssh-rsa',
  key     => $ssh_key,
  require => [User[$myuser]],
}

# change default pi passwd to the same as your other user
user { 'change_default_pi_passwd':
  name    => 'pi',
  password    => $password,
}
