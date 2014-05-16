# Class: sysstat::params
#
# This class defines default parameters used by the main module class sysstat
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to sysstat class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class sysstat::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'sysstat',
  }

  $service = $::operatingsystem ? {
    default => 'sysstat',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/sysstat',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/sysstat/sysstat',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/sysstat',
    default                   => '/etc/sysconfig/sysstat',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/sysstat',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/sysstat',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/sysstat/sa09',
  }

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = 'sysstat/sysstat.erb'
  $init_template = 'sysstat/init.erb'
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = undef

}
