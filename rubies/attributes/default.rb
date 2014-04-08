default[:rubies][:versions] = [
  "2.1.1",
  "2.0.0-p451",
  "1.9.3-p545",
  "1.8.7-p371",
  "1.8.7-p358",
  "jruby-1.7.11"
]
default[:rubies][:source]              = "http://packages.machines.io/rubies"
default[:rubies][:install_path]        = "/opt/rubies"
default[:rubies][:system_ruby_version] = "2.1.1"
default[:rubies][:rbenv_path]          = "/usr/local/rbenv"

# Gems installed on all rubies
default[:rubies][:gems] = [
  ["bundler", "1.6.1"]
]

# Gems installed to the default system ruby
default[:rubies][:system_ruby_gems] = [
  ["chef", "11.10.4"],
  ["backup", "3.10.0"],
  ["remote_syslog", "1.6.14"]
]
