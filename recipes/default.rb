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

when node[:openfire][:install_type]
case "deb"
  include_recipe "openfire::install_deb"
else
  include_recipe "openfire::install_tar"
end
