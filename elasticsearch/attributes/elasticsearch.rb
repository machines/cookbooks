default[:elasticsearch][:version]    = "0.18.5"
default[:elasticsearch][:checksum]   = "ec4cb2115cba5bc4156415b47dd0fcfe4fc054b0704ed07d4c0632e6700cd5b6"
default[:elasticsearch][:dir]        = "elasticsearch-#{elasticsearch[:version]}"
default[:elasticsearch][:source]     = "https://github.com/downloads/elasticsearch/elasticsearch/#{elasticsearch[:dir]}.tar.gz"

# The src will be downloaded here
default[:elasticsearch][:basedir] = "/usr/local/src"
#
# elasticsearch will be unarchived here
default[:elasticsearch][:homedir] = "#{elasticsearch[:basedir]}/#{elasticsearch[:dir]}"
#
# All configs will be stored here
default[:elasticsearch][:configs] = "/etc/elasticsearch"
#
# Path to log files:
default[:elasticsearch][:logs] = "/var/log/elasticsearch"
#
# Path to directory where to store index data allocated for this node.
default[:elasticsearch][:data] = "/var/db/elasticsearch"
#
# Path to temporary files:
default[:elasticsearch][:work] = "/tmp"
#
# The minimum memory allocation for the JVM.
# Default is 256m.
default[:elasticsearch][:min_mem] = "64m"
#
# The maximum memory allocation for the JVM.
# Default is 1g.
default[:elasticsearch][:max_mem] = "256m"

# Number of open files for the elasticsearch user.
# Recommended by the official guide. 655536
# USE THE BOOTSTRAP COOKBOOK FOR THIS
# https://github.com/gchef/bootstrap-cookbook
# default[:elasticsearch][:nofile] = 2**16
#
# Upstart-related, wait this long between SIGTERM and SIGKILL
default[:elasticsearch][:timeout] = 300
#
# ElasticSearch performs poorly when JVM starts swapping: you should ensure that
# it _never_ swaps.
default[:elasticsearch][:mlockall] = true
