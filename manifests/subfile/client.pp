# Configuration subfile for Bacula.
#

define bacula::subfile::client (
  $config_dir     = undef,
  $address        = $::fqdn,
  $catalog        = undef,
  $password       = 'password',
  $fdport         = '9102',
  $file_retention = '60 days',
  $job_retention  = '180 days',
  $auto_prune     = 'yes',
  $maximum_jobs   = '1',
  $priority       = undef,
) {

  $conf_dir_real = $config_dir ? {
    undef   => "${bacula::defaults::config_directory}/clients",
    default => $config_dir,
  }

  $owner = $bacula::director::file_owner

  validate_string($address)
  validate_string($catalog)
  validate_absolute_path("${conf_dir_real}/${type}")

  file { "${conf_dir_real}/${name}":
    ensure  => $ensure,
    mode    => '0440',
    owner   => $owner,
    content => template('bacula/client.erb'),
    require => Class['bacula::director::config'],
    notify  => Class['bacula::director::service'],
  }

}
