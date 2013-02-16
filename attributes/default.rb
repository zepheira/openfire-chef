default[:openfire][:source_tarball] = 'openfire_3_8_0.tar.gz'
default[:openfire][:source_checksum] = 'd5bef61a313ee41b'

default[:openfire][:base_dir] = '/opt'
default[:openfire][:home_dir] = "#{openfire[:base_dir]}/openfire"
default[:openfire][:log_dir] = '/var/log/openfire'

default[:openfire][:user] = 'openfire'
default[:openfire][:group] = 'openfire'

default[:openfire][:pidfile] = '/var/run/openfire.pid'

# by default, only enable secure admin port
default[:openfire][:config][:admin_console][:port] = -1
default[:openfire][:config][:admin_console][:secure_port] = 9091

default[:openfire][:config][:locale] = 'en'
default[:openfire][:config][:network][:interface] = nil
