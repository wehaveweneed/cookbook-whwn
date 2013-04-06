

# Vagrant
default['whwn']['virtualenv'] = '/home/vagrant/.env'
default['whwn']['home'] = '/home/vagrant/whwn'

# set['python']['version'] = "2.7.3"
# set['python']['install_method'] = "source"
# set['python']['checksum'] = "d4c20f2b5faf95999fd5fecb3f7d32071b0820516224a6d2b72932ab47a1cb8e"
# set['python']['prefix_dir'] = "/usr/local"

# force_default['postgis']['version'] = "1.5.8"
# force_default['postgis']['checksum'] = "d1af1e8544b9d22285d81efb63d59a1648c9c960"

# Node
# default[:node][:version] = "v0.8.21"

normal['jenkins']['http_proxy']['variant'] = 'nginx'

# set['postgresql']['version'] = "9.1"
# set['postgresql']['pg_hba_defaults'] = false
# set['postgresql']['pg_hba'] = [
#     { "type" => "local", "db" => "all", "user" => "postgres",   "addr" => "",             "method" => "trust" },
#     { "type" => "local", "db" => "all", "user" => "all",        "addr" => "",             "method" => "trust" },
#     { "type" => "host",  "db" => "all", "user" => "all",        "addr" => "127.0.0.1/32", "method" => "trust" },
#     { "type" => "host",  "db" => "all", "user" => "all",        "addr" => "::1/128",      "method" => "trust" }
# ]
