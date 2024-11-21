package { 'apache2':
  ensure => installed,
}

package { 'php':
  ensure => installed,
  notify  => Service['apache2'],
  require => [Package['apache2']],
}

service { 'apache2':
  ensure => running,
  enable => true,
  require => [Package['apache2'], Package['php']],
}

package { 'php-mysql':
  ensure => installed,
  require => Package['php'],
}

file { '/var/www/html/phpinfo.php':
  source => '/home/youruser/puppet-dev/phpinfo.php',
  notify  => Service['apache2'],
  require => [Package['apache2']],
}

package { 'mariadb-server':
  ensure => installed,
}

service { 'mysql':
  ensure => running,
  enable => true,
  require => Package['mariadb-server'],
}
