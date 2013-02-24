default[:rubies][:versions] = [
  "2.0.0-p0",
  "1.9.3-p392",
  "1.9.3-p327",
  "1.9.3-p286",
  "1.9.3-p194",
  "1.9.2-p320",
  "1.9.2-p290",
  "1.8.7-p371",
  "1.8.7-p358",
  "jruby-1.7.3"
]
default[:rubies][:source]              = "http://packages.machines.io/rubies"
default[:rubies][:install_path]        = "/opt/rubies"
default[:rubies][:system_ruby_version] = "1.9.3-p392"
default[:rubies][:rbenv_path]          = "/usr/local/rbenv"

# Gems installed on all rubies
default[:rubies][:gems] = [
  ["bundler", "1.3.0.pre.8"]
]

# Gems installed to the default system ruby
default[:rubies][:system_ruby_gems] = [
  ["chef", "11.4.0"],
  ["backup", "3.0.27"],
  ["remote_syslog", "1.6.9"]
]
