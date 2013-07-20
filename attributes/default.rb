default[:openfire][:version] = '3.8.2'

default[:openfire][:install_type] = "tar"
default[:openfire][:source_tarball] = 'openfire_3_8_2.tar.gz'
default[:openfire][:source_checksum] = checksums[openfire[:source_tarball]]

default[:openfire][:deb] = 'openfire_3.8.2_all.deb'
default[:openfire][:deb_checksum] = checksums[openfire[:deb]]

# precalculated checksums: `sha256sum openfire_v_v_v.tar.gz | cut -c1-16`
checksums = {
    'openfire_3_8_2.tar.gz' => '3a705ed3f3b82d46',
	'openfire_3_8_1.tar.gz' => '554dce3a1b0a0b88',
	'openfire_3_8_0.tar.gz' => 'd5bef61a313ee41b',
    'openfire_3.8.2_all.deb' => 'c82946f9bbd005ed',
    'openfire_3_8_1_all.deb' => '646602370f2ccd02',
    'openfire_3_8_0_all.deb' => '66b48ea0f4a92d97',
}

default[:openfire][:base_dir] = '/opt'
default[:openfire][:home_dir] = "#{openfire[:base_dir]}/openfire"
default[:openfire][:log_dir] = '/var/log/openfire'
default[:openfire][:config_dir] = '/etc/openfire'

default[:openfire][:user] = 'openfire'
default[:openfire][:group] = 'openfire'

default[:openfire][:pidfile] = '/var/run/openfire.pid'

# by default, only enable secure admin port
default[:openfire][:config][:admin_console][:port] = 9090
default[:openfire][:config][:admin_console][:secure_port] = 9091

default[:openfire][:config][:locale] = 'en'
default[:openfire][:config][:network][:interface] = nil
