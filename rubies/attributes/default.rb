default[:rubies][:versions] = [
  "1.9.3-p286", "1.9.3-p194", "1.9.2-p320", "1.9.2-p290", "1.8.7-p370", "1.8.7-p358"
]
default[:rubies][:source]              = "http://packages.machines.io/rubies"
default[:rubies][:install_path]        = "/opt/rubies"
default[:rubies][:system_ruby_version] = "1.9.3-p286"
default[:rubies][:rbenv_path]          = "/usr/local/rbenv"

# Gems installed on all rubies
default[:rubies][:gems] = [
  ["bundler", "1.2.1"]
]

# Gems installed to the default system ruby
default[:rubies][:system_ruby_gems] = [
  ["chef", "10.16.2"],
  ["god", "0.13.1"],
  ["backup", "3.0.25"],
  ["remote_syslog", "1.6.8"]
]
