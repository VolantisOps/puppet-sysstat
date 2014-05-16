# Puppet module: sysstat

This is a Puppet module for sysstat based on the second generation layout ("NextGen") of bmcclure Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.benmcclure.com

Official git repository: http://github.com/bmcclure/puppet-sysstat

Released under the terms of Apache 2 License.

This module requires functions provided by the bmcclure Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of bmcclure modules check the DOCS directory on bmcclure main modules set.


## USAGE - Basic management

* Install sysstat with default settings

        class { 'sysstat': }

* Install a specific version of sysstat package

        class { 'sysstat':
          version => '1.0.1',
        }

* Disable sysstat service.

        class { 'sysstat':
          disable => true
        }

* Remove sysstat package

        class { 'sysstat':
          absent => true
        }

* Enable auditing without without making changes on existing sysstat configuration *files*

        class { 'sysstat':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'sysstat':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'sysstat':
          source => [ "puppet:///modules/bmcclure/sysstat/sysstat.conf-${hostname}" , "puppet:///modules/bmcclure/sysstat/sysstat.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'sysstat':
          source_dir       => 'puppet:///modules/bmcclure/sysstat/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'sysstat':
          template => 'bmcclure/sysstat/sysstat.conf.erb',
        }

* Automatically include a custom subclass

        class { 'sysstat':
          my_class => 'bmcclure::my_sysstat',
        }


## USAGE - example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'sysstat':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'sysstat':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of bmcclure monitor and relevant monitor tools modules

        class { 'sysstat':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of bmcclure firewall and relevant firewall tools modules

        class { 'sysstat':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/bmcclure/puppet-sysstat.png?branch=master" alt="Build Status" />}[https://travis-ci.org/bmcclure/puppet-sysstat]
