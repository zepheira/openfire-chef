local_tarball_path = "#{Chef::Config[:file_cache_path]}/#{node[:openfire][:source_tarball]}"

remote_file local_tarball_path do
  checksum node[:openfire][:source_checksum]
  source "http://www.igniterealtime.org/downloadServlet?filename=openfire/#{node[:openfire][:source_tarball]}"
end

bash "install_openfire" do
  cwd node[:openfire][:base_dir]
  code <<-EOH
    tar xzf #{local_tarball_path}
    chown -R #{node[:openfire][:user]}:#{node[:openfire][:group]} #{node[:openfire][:home_dir]}
    mv #{node[:openfire][:home_dir]}/conf #{node[:openfire][:config_dir]}
    rm #{node[:openfire][:config_dir]}/openfire.xml
    mv #{node[:openfire][:home_dir]}/logs #{node[:openfire][:log_dir]}
    mv #{node[:openfire][:home_dir]}/resources/security #{node[:openfire][:config_dir]}
  EOH
  creates node[:openfire][:home_dir]
end

# link to LSB-recommended directories
link "#{node[:openfire][:home_dir]}/conf" do
  to node[:openfire][:config_dir]
end

link "#{node[:openfire][:home_dir]}/logs" do
  to node[:openfire][:log_dir]
end

link "#{node[:openfire][:home_dir]}/resources/security" do
  to "#{node[:openfire][:config_dir]}/security"
end

# this directory contains keys, so lock down its permissions
directory "#{node[:openfire][:config_dir]}/security" do
  owner node[:openfire][:user]
  group node[:openfire][:group]
  mode 00700
end

template "#{node[:openfire][:config_dir]}/openfire.xml" do
  action :create_if_missing
  owner node[:openfire][:user]
  group node[:openfire][:group]
  mode 00600
end

cookbook_file "/etc/init.d/openfire" do
  mode 00755
end

# on Debian/Ubuntu we use /etc/default instead of /etc/sysconfig
# make a symlink so that openfirectl is happy
link "/etc/sysconfig" do
  to "/etc/default"
  only_if { node[:platform_family] == "debian" }
end

template "/etc/sysconfig/openfire" do
  mode 00644
end

service "openfire" do
  supports :status => true, 
           :stop => true
  action [ :enable, :start ]
end

admin_console = node[:openfire][:config][:admin_console]
admin_port = (admin_console[:secure_port] == -1)? admin_console[:port] : admin_console[:secure_port]
log "And now visit the server on :#{admin_port} to run the openfire wizard." do
  action :nothing
end
