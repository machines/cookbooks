execute "Add percona apt source" do
  command 'echo "deb http://repo.percona.com/apt oneiric main\ndeb-src http://repo.percona.com/apt oneiric main" >> /etc/apt/sources.list.d/percona.list'
  creates "/etc/apt/sources.list.d/percona.list"
end

execute "Add percona key to apt keyring" do
  command "gpg --keyserver hkp://keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && gpg -a --export CD2EFD2A | apt-key add - && apt-get update"
  not_if "gpg --keyring /etc/apt/trusted.gpg --list-keys | grep '1024D/CD2EFD2A'"
end

package "percona-server-server-5.5" do
  action :install
end
