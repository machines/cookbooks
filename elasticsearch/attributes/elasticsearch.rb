default[:elasticsearch][:version]    = "0.19.2"
default[:elasticsearch][:checksum]   = "adac92d66ce91f42d9e67bd60e6b1335995f5dfdd153165fdcf1fe24b63ac59e"
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
default[:elasticsearch][:logs] = "/mnt/elasticsearch/log"
#
# Path to directory where to store index data allocated for this node.
default[:elasticsearch][:data] = "/mnt/elasticsearch/data"
#
# Path to temporary files:
default[:elasticsearch][:work] = "/tmp"
#
# The minimum memory allocation for the JVM.
# Default is 256m.
default[:elasticsearch][:min_mem] = "128m"
#
# The maximum memory allocation for the JVM.
# Default is 1g.
default[:elasticsearch][:max_mem] = "512m"
#
# Upstart-related, wait this long between SIGTERM and SIGKILL
default[:elasticsearch][:timeout] = 300
#
# ElasticSearch performs poorly when JVM starts swapping: you should ensure that
# it _never_ swaps.
default[:elasticsearch][:mlockall] = true
#
# S3 Gateway
default[:elasticsearch][:s3_gateway][:enabled] = true
default[:elasticsearch][:s3_gateway][:version] = "1.5.0"
default[:elasticsearch][:s3_gateway][:path] = "elasticsearch/elasticsearch-cloud-aws/#{node.elasticsearch.s3_gateway.version}"
