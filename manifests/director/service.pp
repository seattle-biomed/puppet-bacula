# == Class: bacula
#
# Full description of class bacula is in the README.
#
class bacula::director::service (
  $ensure       = $bacula::director::service_ensure,
  $enable       = $bacula::director::service_enable,
  $service_name = $bacula::director::service_name,
  $restart      = $bacula::defaults::dir_restart_command,
) {
  service { $service_name:
    ensure      => $ensure,
    enable      => $enable,
    hasrestart  => true,
    restart     => $restart,
  }
}
