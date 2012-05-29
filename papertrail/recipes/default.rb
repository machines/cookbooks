template "/etc/rsyslog.conf" do
  source "rsyslog.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[rsyslog]", :immediately
end

service "rsyslog" do
  supports restart: true
  action :enable
end
