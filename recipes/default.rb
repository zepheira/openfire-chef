include_recipe "java::default"

if node[:openfire][:database][:active]
  include_recipe "openfire::database"
end

group node[:openfire][:group] do
  system true
end

user node[:openfire][:user] do
  gid node[:openfire][:group]
  home node[:openfire][:home_dir]
  system true
  shell '/bin/sh'
end

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
    mv #{node[:openfire][:home_dir]}/conf /etc/openfire
    mv #{node[:openfire][:home_dir]}/logs /var/log/openfire
  EOH
  creates node[:openfire][:home_dir]
end

# link to LSB-recommended directories
link "#{node[:openfire][:home_dir]}/conf" do
  to '/etc/openfire'
end

template '/etc/openfire/openfire.xml' do
  mode '0644'
end

link "#{node[:openfire][:home_dir]}/logs" do
  to '/var/log/openfire'
end

# ensure openfirectl is executable
file "#{node[:openfire][:home_dir]}/bin/openfirectl" do
  mode '0755'
end

link  "/etc/init.d/openfire" do
  to "#{node[:openfire][:home_dir]}/bin/openfirectl"
end

# on Debian/Ubuntu we use /etc/default instead of /etc/sysconfig
# make a symlink so that openfirectl is happy
link '/etc/sysconfig' do
  to '/etc/default'
  only_if { node[:platform_family] == 'debian' }
end

template '/etc/sysconfig/openfire' do
  mode '0644'
end

service "openfire" do
  supports :status => true, 
           :stop => true
  action [ :enable, :start ]
end

log "And now remember to visit the server on :9090 to run the openfire wizard."
log "You'll also probably want to turn of anonymous sign-ups and whatnot."
