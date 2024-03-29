#
# Cookbook Name:: postgresql
# Recipe:: postgis
#

include_recipe "postgresql"
include_recipe "geos"
include_recipe "apt"

apt_repository "ubuntugis-repo" do
  uri "http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  deb_src true
  keyserver "keyserver.ubuntu.com"
  key "314DF160"
end

packages = ["libxml2-dev", "libproj-dev", "libgdal-dev", "make"] 
packages.each {|dev_pkg| package dev_pkg}

install_path = "#{Chef::Config[:file_cache_path]}/postgis-#{node['postgis']['version']}"
template_name = "template_postgis"
pg_postgis = "/usr/share/postgresql/#{node['postgresql']['version']}/contrib/postgis-1.5/postgis.sql"
pg_spatial_ref = "/usr/share/postgresql/#{node['postgresql']['version']}/contrib/postgis-1.5/spatial_ref_sys.sql"

remote_file "#{install_path}.tar.gz" do
  source "http://download.osgeo.org/postgis/source/postgis-#{node['postgis']['version']}.tar.gz"
  checksum node['postgis']['checksum']
  not_if { ::File.exists?(pg_postgis) }
end

bash "install_postgis" do
  user "root"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -zxf postgis-#{node['postgis']['version']}.tar.gz
    (cd postgis-#{node['postgis']['version']}/ && ./configure && make && make install)
  EOH
  not_if { ::File.exists?(pg_postgis) }
end

bash "configure postgis" do
  code <<-EOH
  createdb -h localhost -l en_US.utf8 -T template0 -O postgres -U postgres -E UTF8 #{template_name}
  createlang plpgsql -h localhost -U postgres -d #{template_name}

  psql -h localhost -q -d #{template_name} -f #{pg_postgis} -U postgres
  psql -h localhost -q -d #{template_name} -f #{pg_spatial_ref} -U postgres
  EOH
  only_if { `psql -U postgres -h localhost -t -c "select count(*) from pg_catalog.pg_database where datname = '#{template_name}'"`.include? '0'}
end
