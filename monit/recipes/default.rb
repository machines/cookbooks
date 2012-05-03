package "monit"

template "monitrc" do
  path "/etc/monit/monitrc"
  source "monitrc.erb"
  owner "root"
  group "root"
  mode "0600"
  notifies :restart, "service[monit]", :immediately
end
