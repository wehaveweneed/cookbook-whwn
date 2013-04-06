#
# Cookbook Name:: whwn
# Recipe:: postgis
#

include_recipe "apt"
package "g++"

include_recipe "postgresql::default"
include_recipe "postgresql::server"
include_recipe "postgresql::server_dev"
include_recipe "postgresql::contrib"
include_recipe "postgresql::libpq"
include_recipe "whwn::postgis"

user "postgres" do
  password "$1$siDybojc$pVgYAJlJBDHXdLmd9f6Gy1"
  action :modify
end

pg_user "whwn" do
  privileges :superuser => true, :createdb => false, :login => true
  password "whwn2012"
end

pg_database "whwn" do
  owner "whwn"
  encoding "utf8"
  template "template_postgis"
end