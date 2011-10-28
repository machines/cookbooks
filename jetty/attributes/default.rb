expand!

default[:jetty][:version]   = "7.5.4.v20111024"
default[:jetty][:link]      = "http://download.eclipse.org/jetty/#{jetty.version}/dist/jetty-distribution-#{jetty.version}.tar.gz"
default[:jetty][:checksum]  = "afaa7b5370931122f4108b1c1eefcc3921960b9eb655f528559aa7ea303d308d"
default[:jetty][:directory] = "/usr/local/src"
default[:jetty][:download]  = "#{jetty.directory}/jetty-distribution-#{jetty.version}.tar.gz"
default[:jetty][:extracted] = "#{jetty.directory}/jetty-distribution-#{jetty.version}"

default[:jetty][:user]      = "jetty"
default[:jetty][:group]     = "adm"
default[:jetty][:home]      = "/usr/share/jetty"
default[:jetty][:port]      = "8983"
default[:jetty][:log_dir]   = "/var/log/jetty"
default[:jetty][:cache]     = "/var/cache/jetty"
