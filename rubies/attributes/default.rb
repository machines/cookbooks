default[:rubies][:versions] = [
  "1.9.3-p194", "1.9.3-p125", "1.9.3-p0", "1.9.2-p320", "1.9.2-p290", "1.8.7-p358", "ree-1.8.7-2012.02"
]
default[:rubies][:source]              = "http://packages.machines.io/rubies"
default[:rubies][:install_path]        = "/opt/rubies"
default[:rubies][:system_ruby_version] = "1.9.3-p194"
default[:rubies][:rbenv_path]          = "/usr/local/rbenv"

# Gems installed on all rubies
default[:rubies][:gems] = [
  ["bundler", "1.1.3"]
]

# Gems installed to the default system ruby
default[:rubies][:system_ruby_gems] = [
  ["chef", "0.10.8"],
  ["god", "0.12.1"],
  ["backup", "3.0.24"]
]
