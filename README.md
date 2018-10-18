# Redmine IPAM
This is an attempt to implement an IPAM as a Redmine plugin.

![redmine_ipam](https://raw.githubusercontent.com/davidegiacometti/redmine_ipam/master/screenshots/redmine_ipam.png)


This is just a concept with a lot of missing feature that needs to be implemented:
* Host history
* Link hosts to issues
* Rake task for schedule scans

## Supported versions
The plugin has been developed and tested on Redmine 3.4.x but should also works on previous versions.

## Installation
* Clone in #{RAILS_ROOT}/plugins
* Install gems running `bundle install`
* Migrate database running `rake redmine:plugins:migrate NAME=redmine_ipam`
* Restart Redmine

## License
Released under the MIT License.
