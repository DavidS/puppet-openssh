# Class: openssh
#
# This is the main openssh class
#
#
# == Parameters
#
# Standard class parameters - Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations 
#   If defined, openssh class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $openssh_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, openssh main config file will have the parameter: source => $source
#   Can be defined also by the (top scope) variable $openssh_source
#
# [*source_dir*]
#   If defined, the whole openssh configuration directory content is retrieved recursively from
#   the specified source (parameter: source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $openssh_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false)  the existing configuration directory is mirrored with the 
#   content retrieved from source_dir. (source => $source_dir , recurse => true , purge => true) 
#   Can be defined also by the (top scope) variable $openssh_source_dir_purge
#
# [*template*]
#   Sets the path to the template to be used as content for main configuration file
#   If defined, openssh main config file will have: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $openssh_template
#
# [*options*]
#   An hash of custom options that can be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $openssh_options
# 
# [*absent*] 
#   Set to 'true' to remove package(s) installed by module 
#   Can be defined also by the (top scope) variable $openssh_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $openssh_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by an external tool, like a cluster software
#   Can be defined also by the (top scope) variable $openssh_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $openssh_monitor and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module) you want to use for openssh
#   Can be defined also by the (top scope) variables $openssh_monitor_tool and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools. Default is the fact $ip_address
#   Can be defined also by the (top scope) variables $openssh_monitor_target and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $openssh_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module is specified in params.pp
#   and is generally a good choice. You can customize the output of puppi commands for this module
#   using a different puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $openssh_puppi_helper and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $openssh_firewall and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module) you want to use for openssh
#   Can be defined also by the (top scope) variables $openssh_firewall_tool and $firewall_tool
#
# [*firewall_src*]
#   Define which source address/net allow for firewalling openssh. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $openssh_firewall_src and $firewall_src
#
# [*firewall_dst*]
#   Define which destination address/net use for firewalling openssh. Default: $ipaddress
#   Can be defined also by the (top scope) variables $openssh_firewall_dst and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $openssh_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files and want to audit the
#   difference between existing files and the ones that Puppet would provide
#   Can be defined also by the (top scope) variables $openssh_audit_only and $audit_only
# 
# Default class params - As defined in openssh::params.
# Note that these variables are mostly defined and used in the module itself, overriding the default
# values might not affected all the involved components (ie: packages layout)
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of openssh package 
# 
# [*service*]
#   The name of openssh service
#
# [*service_status*]
#   If the openssh service init script supports status argument
#
# [*process*]
#   The name of openssh process 
#
# [*process_args*]
#   The name of openssh arguments. Defined when the openssh process is generic (java, ruby...) 
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
# [*pid_file*]
#   Path of pid file. Used by monitor 
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
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $openssh_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $openssh_protocol
#
#
# == Examples
# 
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include openssh"
# - Call openssh as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class openssh (
  $my_class          = $openssh::params::my_class,
  $source            = $openssh::params::source,
  $source_dir        = $openssh::params::source_dir,
  $source_dir_purge  = $openssh::params::source_dir_purge,
  $template          = $openssh::params::template,
  $options           = $openssh::params::options,
  $absent            = $openssh::params::absent,
  $disable           = $openssh::params::disable,
  $disableboot       = $openssh::params::disableboot,
  $monitor           = $openssh::params::monitor,
  $monitor_tool      = $openssh::params::monitor_tool,
  $monitor_target    = $openssh::params::monitor_target,
  $puppi             = $openssh::params::puppi,
  $puppi_helper      = $openssh::params::puppi_helper,
  $firewall          = $openssh::params::firewall,
  $firewall_tool     = $openssh::params::firewall_tool,
  $firewall_src      = $openssh::params::firewall_src, 
  $firewall_dst      = $openssh::params::firewall_dst,
  $debug             = $openssh::params::debug,
  $audit_only        = $openssh::params::audit_only,
  $package           = $openssh::params::package,   
  $service           = $openssh::params::service, 
  $service_status    = $openssh::params::service_status, 
  $process           = $openssh::params::process,
  $process_args      = $openssh::params::process_args,
  $config_dir        = $openssh::params::config_dir,
  $config_file       = $openssh::params::config_file,
  $config_file_mode  = $openssh::params::config_file_mode,
  $config_file_owner = $openssh::params::config_file_owner,
  $config_file_group = $openssh::params::config_file_group,
  $config_file_init  = $openssh::params::config_file_init,
  $pid_file          = $openssh::params::pid_file, 
  $data_dir          = $openssh::params::data_dir, 
  $log_dir           = $openssh::params::log_dir, 
  $log_file          = $openssh::params::log_file, 
  $port              = $openssh::params::port,
  $protocol          = $openssh::params::protocol
  ) inherits openssh::params {

  validate_bool($source_dir_purge , $absent , $disable , $disableboot, $monitor , $puppi , $firewall , $debug, $audit_only)

  ### Definition of some variables used in the module
  $manage_package = $openssh::absent ? {
    true  => "absent",
    false => "present",
  }
 
  $manage_service_enable = $openssh::disableboot ? {
    true    => false,
    default => $openssh::disable ? {
      true  => false,
      default => $openssh::absent ? {
          true  => false,
          false => true,
      },
    },
  }

  $manage_service_ensure = $openssh::disable ? {
    true  => "stopped",
    default =>  $openssh::absent ? {
      true    => "stopped",
      default => "running",
    },
  }

  $manage_file = $openssh::absent ? {
    true    => "absent",
    default => "present",
  }

  $manage_monitor = $openssh::absent ? {
    true  => false ,
    default => $openssh::disable ? {
      true    => false,
      default => true,
    }
  }

  $manage_audit = $openssh::audit_only ? {
    true  => "all",
    false => undef,
  }

  $manage_file_replace = $openssh::audit_only ? {
    true  => false,
    false => true,
  }


  ### Managed resources
  package { "openssh":
    name   => "${openssh::package}",
    ensure => "${openssh::manage_package}",
  }

  service { "openssh":
    name       => "${openssh::service}",
    ensure     => "${openssh::manage_service_ensure}",
    enable     => $openssh::manage_service_enable,
    hasstatus  => "${openssh::service_status}",
    pattern    => "${openssh::process}",
    require    => Package["openssh"],
    subscribe  => File["openssh.conf"],
  }

  file { "openssh.conf":
    path    => "${openssh::config_file}",
    mode    => "${openssh::config_file_mode}",
    owner   => "${openssh::config_file_owner}",
    group   => "${openssh::config_file_group}",
    ensure  => "${openssh::manage_file}",
    require => Package["openssh"],
    notify  => Service["openssh"],
    source  => $source ? {
      ''      => undef,
      default => $source,
    },
    content => $template ? {
      ''      => undef,
      default => template("$template"),
    },
    replace => "${openssh::manage_file_replace}",
    audit   => $openssh::manage_audit,
  }

  # The whole openssh configuration directory can be recursively overriden
  if $openssh::source_dir {
    file { "openssh.dir":
      path    => "${openssh::config_dir}",
      ensure  => directory,
      require => Class["openssh::install"],
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      replace => "${openssh::manage_file_replace}",
      audit   => $openssh::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $openssh::my_class {
    include $openssh::my_class
  } 


  ### Provide puppi data, if enabled ( puppi => true )
  if $openssh::puppi == true { 
    $puppivars=get_class_args()
    file { "puppi_openssh":
      path    => "${settings::vardir}/puppi/openssh",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      ensure  => "${openssh::manage_file}",
      require => Class["puppi"],         
      content => inline_template("<%= puppivars.to_yaml %>"),
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $openssh::monitor == true { 
    monitor::port { "openssh_${openssh::protocol}_${openssh::port}": 
      protocol => "${openssh::protocol}",
      port     => "${openssh::port}",
      target   => "${openssh::params::monitor_target}",
      tool     => "${openssh::monitor_tool}",
      enable   => $openssh::manage_monitor,
    }
    monitor::process { "openssh_process":
      process  => "${openssh::process}",
      service  => "${openssh::service}",
      pidfile  => "${openssh::pidfile}",
      tool     => "${openssh::monitor_tool}",
      enable   => $openssh::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $openssh::firewall == true {  
    firewall { "openssh_${openssh::protocol}_${openssh::port}":
      source      => "${openssh::firewall_source}",
      destination => "${openssh::firewall_destination}",
      protocol    => "${openssh::protocol}",
      port        => "${openssh::port}",
      action      => "allow",
      direction   => "input",
      tool        => "${openssh::firewall_tool}",
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $openssh::debug == true {
    file { "debug_openssh":
      path    => "${settings::vardir}/debug-openssh",
      mode    => "0640",
      owner   => "root",
      group   => "root",
      ensure  => "$openssh::manage_file",
      content => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>"),
    }
  }

}
