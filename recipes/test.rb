# Cookbook Name:: aem_disp_config
# Recipe:: default
#
# Copyright 2014, cru
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'
include_recipe 'apache2'

service 'apache2' do
    supports :status => true, :restart => true
    provider Chef::Provider::Service::Init
end

if ["prod.dispatcher1"].include?(Chef::Config[:node_name])
	host_alias1 = "prod6dis1.cru.org"
elsif ["prod.dispatcher2"].include?(Chef::Config[:node_name])
	host_alias1 = "prod6dis2.cru.org"
elsif ["prod.dispatcher3"].include?(Chef::Config[:node_name])
	host_alias1 = "prod6dis3.cru.org"
elsif ["prod.dispatcher4"].include?(Chef::Config[:node_name])
	host_alias1 = "prod6dis4.cru.org"
else
	host_alias1 = "nil"
end


apache_home = node['aem']['apache']['home']

template "#{apache_home}/sites-available/cruorg" do
    source 'cruorg.erb'
    owner "root"
    group "root"
    mode 0644
    variables(
              :host_name => node['hostname'],
              :host_ip => node['ipaddress'],
              :host_alias => '#{host_alias1}',
              :site => node['dispatcher']['site'],
              :site_alias1 => node['dispatcher']['alias1'],
              :site_alias2 => node['dispatcher']['alias2'],
	      :server_admin => node['vhost']['email']
              )
	notifies :restart, "service[apache2]", :immediately
	only_if File.exist?("#{apache_home}/sites-available/")
end
