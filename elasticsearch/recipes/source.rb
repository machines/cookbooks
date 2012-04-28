user "elasticsearch" do
  system true
  shell "/bin/sh"
end

remote_file "#{node.elasticsearch.homedir}.tar.gz" do
  source node.elasticsearch.source
  checksum node.elasticsearch.checksum
  action :create_if_missing
end

bash "Setup elasticsearch v#{node[:elasticsearch][:version]}" do
  cwd "#{node.elasticsearch.basedir}"
  code %{
    if [ ! -d #{node.elasticsearch.dir} ]; then
      tar zxf #{node.elasticsearch.dir}.tar.gz
    fi
    ln -nfs #{node.elasticsearch.homedir}/bin/elasticsearch /usr/local/bin/elasticsearch
    ln -nfs #{node.elasticsearch.homedir}/lib /usr/local/lib/elasticsearch
  }
end

if node.elasticsearch.s3_gateway.enabled
  bash "Install elasticsearch S3 gateway plugin" do
    cwd "#{node.elasticsearch.basedir}"
    code "#{node.elasticsearch.dir}/bin/plugin -install #{node.elasticsearch.s3_gateway.path}"
  end
end

service "elasticsearch" do
  supports :start => true, :stop => true, :restart => true
  provider Chef::Provider::Service::Upstart
end

template "/etc/init/elasticsearch.conf" do
  cookbook "elasticsearch"
  source "elasticsearch.upstart.erb"
  owner "root"
  group "root"
  mode "0644"
  backup false
  notifies :restart, resources(:service => "elasticsearch")
end

[
  node.elasticsearch.configs,
  node.elasticsearch.data,
  node.elasticsearch.logs
].each do |dir|
  directory dir do
    owner "elasticsearch"
    group "elasticsearch"
    mode "0750"
    recursive true
  end
end

[
  "elasticsearch.yml",
  "logging.yml",
  "elasticsearch.in.sh"
].each do |elasticsearch_config|
  template "#{node[:elasticsearch][:configs]}/#{elasticsearch_config}" do
    owner "root"
    group "root"
    mode "0644"
    backup false
    notifies :restart, resources(:service => "elasticsearch"), :delayed
  end
end

service "elasticsearch" do
  action [:enable, :start]
end
