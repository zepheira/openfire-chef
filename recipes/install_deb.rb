include_recipe "java::default"

local_deb_path = "#{Chef::Config[:file_cache_path]}/#{node[:openfire][:deb]}"

remote_file local_deb_path do
  checksum node[:openfire][:deb_checksum]
  source "http://www.igniterealtime.org/downloadServlet?filename=openfire/#{node[:openfire][:deb]}"
end

dpkg_package "openfire" do
  source local_deb_path
  # don't downgrade or install same version, keep old conf when no default
  options "-G -E --force-confdef --force-confold"
  action :install
end

template "#{node[:openfire][:config_dir]}/openfire.xml" do
  action :create_if_missing
  owner node[:openfire][:user]
  group node[:openfire][:group]
  mode 00600
end

directory "#{node[:openfire][:config_dir]}/security" do
  owner node[:openfire][:user]
  group node[:openfire][:group]
  mode 00750
end

service "openfire" do
  supports :restart => true, 
           :stop => true
  action [ :enable, :start ]
end

admin_console = node[:openfire][:config][:admin_console]
admin_port = (admin_console[:secure_port] == -1)? admin_console[:port] : admin_console[:secure_port]

log "And now visit the server on :#{admin_port} to run the openfire wizard." do
  action :nothing
end
