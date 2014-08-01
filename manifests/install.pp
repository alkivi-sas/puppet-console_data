class console_data::install (
  $keymap         = $console_data::keymap,
  $keymap_select  = $console_data::keymap_select,
  $keymap_full    = $console_data::keymap_full,
  $keymap_family  = $console_data::keymap_family,
  $bootmap_md5sum = $console_data::bootmap_md5sum,
) {

  if(! defined(File['/root/preseed/']))
  {
    file { '/root/preseed':
      ensure => directory,
      mode   => '0750',
    }
  }

  file { '/root/preseed/console_data.preseed':
    content => template('console_data/preseed.erb'),
    mode    => '0600',
    backup  => false,
    require => File['/root/preseed'],
  }

 
  package { $console_data::params::package_name:
    ensure       => installed,
    responsefile => '/root/preseed/console_data.preseed',
    require      => File['/root/preseed/console_data.preseed'],
  }
}
