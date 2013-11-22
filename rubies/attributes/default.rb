default[:rubies][:versions] = [
  "2.0.0-p353",
  "2.0.0-p247",
  "1.9.3-p484",
  "1.9.3-p448",
  "1.9.3-p429",
  "1.9.3-p392",
  "1.9.3-p327",
  "1.9.3-p286",
  "1.9.3-p194",
  "1.9.2-p320",
  "1.9.2-p290",
  "1.8.7-p371",
  "1.8.7-p358",
  "jruby-1.7.8"
]
default[:rubies][:source]              = "http://packages.machines.io/rubies"
default[:rubies][:install_path]        = "/opt/rubies"
default[:rubies][:system_ruby_version] = "1.9.3-p484"
default[:rubies][:rbenv_path]          = "/usr/local/rbenv"

# Gems installed on all rubies
default[:rubies][:gems] = [
  ["bundler", "1.3.5"]
]

# Gems installed to the default system ruby
default[:rubies][:system_ruby_gems] = [
  ["chef", "11.6.2"],
  ["backup", "3.7.2"],
  ["remote_syslog", "1.6.14"]
]
