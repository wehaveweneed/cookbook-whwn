

# Vagrant
default['whwn']['virtualenv'] = '/home/vagrant/.env'
default['whwn']['home'] = '/home/vagrant/whwn'

# Node
default[:node][:version] = "v0.8.21"

normal['jenkins']['http_proxy']['variant'] = 'nginx'
