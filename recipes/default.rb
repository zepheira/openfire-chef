#
# Cookbook Name:: openfire
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

include_recipe "java::default"

source_tarball = "openfire_3_7_1.tar.gz"

remote_file "/tmp/#{source_tarball}" do
  source "http://www.igniterealtime.org/downloadServlet?filename=openfire/#{source_tarball}"
  mode "0644"
  # check the checksum
end

execute "tar" do
  cwd "/opt"
  command "tar xzf /tmp/#{source_tarball}"
  creates "/opt/openfire"
end


log "And now remember to visit the server on :9090 to run the openfire wizard - actually, that's not true. You'll have to boot it first"
