configure_flags = [
  "--prefix=#{node.nginx.install_path}",
  "--conf-path=#{node.nginx.dir}/nginx.conf",
  "--with-http_ssl_module",
  "--with-http_gzip_static_module",
]

if node.nginx.passenger.enabled
  configure_flags << "--add-module=#{node.nginx.passenger.nginx_module_path}"

  git node.nginx.passenger.root do
    repository "git://github.com/FooBarWidget/passenger.git"
    reference node.nginx.passenger.git_revision
    action :sync
  end
end

remote_file "/usr/local/src/nginx-#{node.nginx.version}.tar.gz" do
  source "http://nginx.org/download/nginx-#{node.nginx.version}.tar.gz"
  checksum node.nginx.checksum
  action :create_if_missing
end

bash "compile_nginx_source" do
  cwd "/usr/local/src"
  code <<-EOH
    tar zxf nginx-#{node.nginx.version}.tar.gz
    cd nginx-#{node.nginx.version} && ./configure #{configure_flags.join(" ")}
    make && make install
  EOH
  not_if do
    if node.nginx.passenger.enabled
      File.exists?("#{node.nginx.passenger.root}/libout") && File.exists("#{node.nginx.install_path}/sbin/nginx")
    else
      File.exists("#{node.nginx.install_path}/sbin/nginx")
    end
  end
  notifies :restart, "service[nginx]"
end

directory node.nginx.log_dir do
  mode 0755
  owner node.nginx.user
end

directory node.nginx.dir do
  owner "root"
  group "root"
  mode "0755"
end

directory "/mnt/default-host/public" do
  owner node.deploy_user
  group node.deploy_user
  mode "0755"
  recursive true
end

template "/mnt/default-host/public/index.html" do
  source "default-host-page.html.erb"
  owner node.deploy_user
  group node.deploy_user
  mode "0755"
end

template "/etc/init.d/nginx" do
  source "nginx.init.erb"
  owner "root"
  group "root"
  mode "0755"
end

directory "#{node.nginx.dir}/sites" do
  owner node.deploy_user
  group node.deploy_user
  mode "0755"
end

template "default-host.conf" do
  path "#{node.nginx.dir}/default-host.conf"
  source "default-host.erb"
  owner node.deploy_user
  group node.deploy_user
  mode "0644"
  notifies :reload, "service[nginx]", :delayed
end

template "nginx.conf" do
  path "#{node.nginx.dir}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, "service[nginx]", :immediately
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end
