# Load settings from data bag 'elasticsearch/settings'
#
settings = Chef::DataBagItem.load('elasticsearch', 'settings')[node.chef_environment] rescue {}
Chef::Log.debug "Loaded settings: #{settings.inspect}"

# Initialize the node attributes with node attributes merged with data bag attributes
#
node.default[:elasticsearch] ||= {}
node.normal[:elasticsearch]  ||= {}
node.normal[:elasticsearch]    = DeepMerge.merge(node.default[:elasticsearch].to_hash, node.normal[:elasticsearch].to_hash)
node.normal[:elasticsearch]    = DeepMerge.merge(node.normal[:elasticsearch].to_hash, settings.to_hash)

# === VERSION AND LOCATION
#
default.elasticsearch[:version]       = "0.90.1"
default.elasticsearch[:checksum]      = "2a5d4390a24a7feff12a0f1ac0e75c53b333316c44cf2e783dad9d7d7b03fb5b"
default.elasticsearch[:host]          = "http://download.elasticsearch.org"
default.elasticsearch[:repository]    = "elasticsearch/elasticsearch"
default.elasticsearch[:filename]      = "elasticsearch-#{node.elasticsearch[:version]}.tar.gz"
default.elasticsearch[:download_url]  = [node.elasticsearch[:host], node.elasticsearch[:repository], node.elasticsearch[:filename]].join('/')

# === NAMING
#
default.elasticsearch[:cluster][:name] = 'elasticsearch'
default.elasticsearch[:node][:name]    = node.name

# === USER & PATHS
#
default.elasticsearch[:dir]       = "/usr/local"
default.elasticsearch[:user]      = "elasticsearch"

default.elasticsearch[:path][:conf] = "/usr/local/etc/elasticsearch"
default.elasticsearch[:path][:data] = "/mnt/data/elasticsearch"
default.elasticsearch[:path][:logs] = "/mnt/log/elasticsearch"

default.elasticsearch[:pid_path]  = "/mnt/run/elasticsearch"
default.elasticsearch[:pid_file]  = "#{node.elasticsearch[:pid_path]}/#{node.elasticsearch[:node][:name].to_s.gsub(/\W/, '_')}.pid"

# Deprecation notice for legacy path configuration
Chef::Log.warn "DEPRECATION WARNING! The 'conf_path', 'data_path' and 'log_path' attributes have changed, and will be removed in the next release. Please review your attributes."
default.elasticsearch[:conf_path] = default.elasticsearch[:path][:conf]
default.elasticsearch[:data_path] = default.elasticsearch[:path][:data]
default.elasticsearch[:log_path]  = default.elasticsearch[:path][:logs]

# === MEMORY
#
# Maximum amount of memory to use is automatically computed as one half of total available memory on the machine.
# You may choose to set it in your node/role configuration instead.
#
allocated_memory = "#{(node.memory.total.to_i * 0.6 ).floor / 1024}m"
default.elasticsearch[:allocated_memory] = allocated_memory

# === LIMITS
#
# By default, the `mlockall` is set to true: on weak machines and Vagrant boxes,
# you may want to disable it.
#
default.elasticsearch[:bootstrap][:mlockall] = true
default.elasticsearch[:limits][:memlock] = 'unlimited'
default.elasticsearch[:limits][:nofile]  = '64000'

# === PRODUCTION SETTINGS
#
default.elasticsearch[:index][:mapper][:dynamic]   = true
default.elasticsearch[:action][:auto_create_index] = true
default.elasticsearch[:action][:disable_delete_all_indices] = true
default.elasticsearch[:node][:max_local_storage_nodes] = 1

default.elasticsearch[:discovery][:zen][:ping][:multicast][:enabled] = true
default.elasticsearch[:discovery][:zen][:minimum_master_nodes] = 1
default.elasticsearch[:gateway][:type] = 'local'
default.elasticsearch[:gateway][:expected_nodes] = 1

default.elasticsearch[:thread_stack_size] = "256k"

# === CUSTOM CONFIGURATION
#
default.elasticsearch[:custom_config] = {}

# --------------------------------------------------
# NOTE: Setting the attributes for elasticsearch.yml
# --------------------------------------------------
#
# The template uses the `print_value` extension method to print attributes with a "truthy"
# value, set either in data bags, node attributes, role override attributes, etc.
#
# It is possible to set *any* configuration value exposed by the Elasticsearch configuration file.
#
# For example:
#
#     <%= print_value 'cluster.routing.allocation.node_concurrent_recoveries' -%>
#
# will print a line:
#
#     cluster.routing.allocation.node_concurrent_recoveries: <VALUE>
#
# if the either of following node attributes is set:
#
# * `node.cluster.routing.allocation.node_concurrent_recoveries`
# * `node['cluster.routing.allocation.node_concurrent_recoveries']`
#
# The default attributes set by the cookbook configure a minimal set inferred from the environment
# (eg. memory settings, node name), or reasonable defaults for production.
#
# The template is based on the elasticsearch.yml file from the Elasticsearch distribution;
# to set other configurations, set the `node.elasticsearch[:custom_config]` attribute in the
# node configuration, `elasticsearch/settings` data bag, role/environment definition, etc:
#
#     // ...
#     'threadpool.index.type' => 'fixed',
#     'threadpool.index.size' => '2'
#     // ...
#
