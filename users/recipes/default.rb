sysadmin_group = Array.new

data_bag("users").each do |user|

  u = data_bag_item("users", user)

  sysadmin_group << u['id']

  home_dir = "/home/#{u['id']}"

  user u['id'] do
    uid u['uid']
    gid u['gid']
    shell u['shell']
    comment u['comment']
    supports :manage_home => true
    home home_dir
  end

  directory "#{home_dir}/.ssh" do
    owner u['id']
    group u['gid'] || u['id']
    mode "0700"
  end

  template "#{home_dir}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner u['id']
    group u['gid'] || u['id']
    mode "0600"
    variables :ssh_keys => u['ssh_keys']
  end
end

group "sysadmin" do
  gid 2300
  members sysadmin_group
end
