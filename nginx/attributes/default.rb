default[:nginx][:version]  = "1.2.2"
default[:nginx][:checksum] = "409477c7a9fba58c110a176fd7965b9db188bcf8be0e7f8a0731b8ae1e6ee880"

default[:nginx][:dir]          = "/etc/nginx"
default[:nginx][:log_dir]      = "/var/log/nginx"
default[:nginx][:install_path] = "/opt/nginx-#{node.nginx.version}"
default[:nginx][:binary]       = "#{node.nginx.install_path}/sbin/nginx"

default[:nginx][:user]                 = "www-data"
default[:nginx][:worker_processes]     = cpu[:total] * 3
default[:nginx][:worker_rlimit_nofile] = 1024
default[:nginx][:pid]                  = "/var/run/nginx.pid"

default[:nginx][:worker_connections] = 1024
default[:nginx][:multi_accept]       = "off"

default[:nginx][:client_body_timeout]           = 60
default[:nginx][:client_header_timeout]         = 60
default[:nginx][:keepalive_timeout]             = 75
default[:nginx][:send_timeout]                  = 60
default[:nginx][:types_hash_max_size]           = 2048
default[:nginx][:server_tokens]                 = "off"
default[:nginx][:server_names_hash_bucket_size] = 64
default[:nginx][:server_name_in_redirect]       = "off"
default[:nginx][:client_max_body_size]          = "100M"

default[:nginx][:gzip]              = "on"
default[:nginx][:gzip_disable]      = "msie6"

default[:nginx][:gzip_vary]         = "on"
default[:nginx][:gzip_proxied]      = "any"
default[:nginx][:gzip_comp_level]   = 2
default[:nginx][:gzip_min_length]   = "1024"
default[:nginx][:gzip_buffers]      = "16 8k"
default[:nginx][:gzip_http_version] = "1.1"
default[:nginx][:gzip_types] = [
  "text/plain",
  "text/css",
  "application/json",
  "application/x-javascript",
  "text/xml",
  "application/xml",
  "application/xml+rss",
  "text/javascript"
]

# Optional Phusion Passenger module
default[:nginx][:passenger][:enabled]               = true
default[:nginx][:passenger][:git_revision]          = "e73ea52caeec8391a39e87e9bbf815935e0f6912"
default[:nginx][:passenger][:root]                  = "/usr/local/src/passenger-#{nginx.passenger.git_revision}"
default[:nginx][:passenger][:nginx_module_path]     = File.join(nginx.passenger.root, 'ext/nginx')
default[:nginx][:passenger][:log_level]             = 0
default[:nginx][:passenger][:spawn_method]          = "smart"
default[:nginx][:passenger][:pool_idle_time]        = 300
default[:nginx][:passenger][:max_instances_per_app] = 0

# Set a max process count - assumes that each app process takes up 150MB real memory
default[:nginx][:passenger][:max_pool_size] = node.memory.total.to_i / 1024 / 150

# Custom memory management of Passenger instances
default[:nginx][:passenger][:memory_management_enabled] = true
default[:nginx][:passenger][:max_memory_per_instance]   = 400
