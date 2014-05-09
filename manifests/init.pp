# = Class: sysstat
#
# This is the main sysstat class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, sysstat class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $sysstat_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, sysstat main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $sysstat_source
#
# [*source_dir*]
#   If defined, the whole sysstat configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $sysstat_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $sysstat_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, sysstat main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $sysstat_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $sysstat_options
#
# [*service_autorestart*]
#   Automatically restarts the sysstat service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $sysstat_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $sysstat_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $sysstat_disableboot
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $sysstat_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $sysstat_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $sysstat_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $sysstat_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: undef
#
# Default class params - As defined in sysstat::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of sysstat package
#
# [*service*]
#   The name of sysstat service
#
# [*service_status*]
#   If the sysstat service init script supports status argument
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# See README for usage patterns.
#
class sysstat (
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $noops               = params_lookup( 'noops' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  ) inherits sysstat::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $sysstat::bool_absent ? {
    true    => 'absent',
    default => $sysstat::version,
  }

  $manage_service_enable = $sysstat::bool_disableboot ? {
    true    => false,
    default => $sysstat::bool_disable ? {
      true    => false,
      default => $sysstat::bool_absent ? {
        true    => false,
        default => true,
      },
    },
  }

  $manage_service_autorestart = $sysstat::bool_service_autorestart ? {
    true    => Service[sysstat],
    default => undef,
  }

  $manage_file = $sysstat::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  $manage_audit = $sysstat::bool_audit_only ? {
    true    => 'all',
    default => undef,
  }

  $manage_file_replace = $sysstat::bool_audit_only ? {
    true    => false,
    default => true,
  }

  $manage_file_source = $sysstat::source ? {
    ''        => undef,
    default   => $sysstat::source,
  }

  $manage_file_content = $sysstat::template ? {
    ''        => undef,
    default   => template($sysstat::template),
  }

  ### Managed resources
  package { $sysstat::package:
    ensure  => $sysstat::manage_package,
    noop    => $sysstat::noops,
  }

  service { 'sysstat':
    name       => $sysstat::service,
    enable     => $sysstat::manage_service_enable,
    hasstatus  => $sysstat::service_status,
    require    => Package[$sysstat::package],
    noop       => $sysstat::noops,
  }

  file { 'sysstat.conf':
    ensure  => $sysstat::manage_file,
    path    => $sysstat::config_file,
    mode    => $sysstat::config_file_mode,
    owner   => $sysstat::config_file_owner,
    group   => $sysstat::config_file_group,
    require => Package[$sysstat::package],
    notify  => $sysstat::manage_service_autorestart,
    source  => $sysstat::manage_file_source,
    content => $sysstat::manage_file_content,
    replace => $sysstat::manage_file_replace,
    audit   => $sysstat::manage_audit,
    noop    => $sysstat::noops,
  }

  # The whole sysstat configuration directory can be recursively overriden
  if $sysstat::source_dir {
    file { 'sysstat.dir':
      ensure  => directory,
      path    => $sysstat::config_dir,
      require => Package[$sysstat::package],
      notify  => $sysstat::manage_service_autorestart,
      source  => $sysstat::source_dir,
      recurse => true,
      purge   => $sysstat::bool_source_dir_purge,
      force   => $sysstat::bool_source_dir_purge,
      replace => $sysstat::manage_file_replace,
      audit   => $sysstat::manage_audit,
      noop    => $sysstat::noops,
    }
  }


  ### Include custom class if $my_class is set
  if $sysstat::my_class {
    include $sysstat::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $sysstat::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'sysstat':
      ensure    => $sysstat::manage_file,
      variables => $classvars,
      helper    => $sysstat::puppi_helper,
      noop      => $sysstat::noops,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $sysstat::bool_debug == true {
    file { 'debug_sysstat':
      ensure  => $sysstat::manage_file,
      path    => "${settings::vardir}/debug-sysstat",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $sysstat::noops,
    }
  }

}
