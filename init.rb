require 'resolv'
require 'active_job'

load "#{Rails.root}/plugins/redmine_ipam/app/jobs/scan_network_job.rb"

Redmine::Plugin.register :redmine_ipam do
  # Generic plugin settings
  name 'Redmine IPAM'
  author 'Davide Giacometti'
  description 'A beautiful implementation an IPAM in Redmine'
  version '0.0.1'
  url 'https://github.com/davidegiacometti/redmine_ipam'
  author_url 'https://github.com/davidegiacometti'

  project_module :redmine_ipam do
    # Network permissions
    permission :view_networks, :networks => [:index, :show]
    permission :add_networks, :networks => [:new, :create]
    permission :edit_networks, :networks => [:edit, :update]
    permission :delete_networks, :networks => :destroy
    permission :scan_networks, :networks => :scan

    # Host permissions
    permission :scan_hosts, :hosts => :scan
  end

  # Menu
  menu :project_menu, :networks, {:controller => 'networks', :action => 'index'}, :caption => 'IPAM', :before => :settings, :param => :project_id
end
