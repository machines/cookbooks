default[:rubies][:versions] = [
  "2.0.0-rc1",
  "1.9.3-p374",
  "1.9.3-p327",
  "1.9.3-p286",
  "1.9.3-p194",
  "1.9.2-p320",
  "1.9.2-p290",
  "1.8.7-p371",
  "1.8.7-p358",
  "jruby-1.7.2"
]
default[:rubies][:source]              = "http://packages.machines.io/rubies"
default[:rubies][:install_path]        = "/opt/rubies"
default[:rubies][:system_ruby_version] = "1.9.3-p374"
default[:rubies][:rbenv_path]          = "/usr/local/rbenv"

# Gems installed on all rubies
default[:rubies][:gems] = [
  ["bundler", "1.3.0.pre.7"]
]

# Gems installed to the default system ruby
default[:rubies][:system_ruby_gems] = [
  ["chef", "11.0.0"],
  ["god", "0.13.1"],
  ["backup", "3.0.27"],
  ["remote_syslog", "1.6.9"]
]
