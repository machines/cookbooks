# Install all rubies and their gems
node.rubies.versions.each do |ruby|

  remote_file "/opt/rubies/#{ruby}.tgz" do
    source "#{node.rubies.source}/#{ruby}.tgz"
    action :create_if_missing
  end

  bash "unarchive #{ruby}" do
    cwd node.rubies.install_path
    code %{
      if [ ! -d #{ruby} ]; then
        tar zxf #{ruby}.tgz
      fi
    }
  end

  gems = node.rubies.gems
  gems += node.rubies.system_ruby_gems if ruby == node.rubies.system_ruby_version

  gems.each do |g|
    bash "install #{g[0]} #{g[1]} to #{ruby}" do
      cwd "/opt/rubies/#{ruby}/bin"
      code "./gem install #{g[0]} -v #{g[1]} --no-rdoc --no-ri"
      not_if %(./gem list --local | grep -E "(#{g[0]})(.+)(#{g[1]})"), cwd: "/opt/rubies/#{ruby}/bin"
    end
  end

end

# Set the defaults system ruby
bash "set default ruby to #{node.rubies.system_ruby_version}" do
  code "#{node.rubies.rbenv_path}/bin/rbenv global #{node.rubies.system_ruby_version}"
end

# Rehash
bash "rbenv rehash" do
  code "#{node.rubies.rbenv_path}/bin/rbenv rehash"
end
