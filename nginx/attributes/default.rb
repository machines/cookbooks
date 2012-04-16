default[:nginx][:version]            = "1.0.15"
default[:nginx][:checksum]           = "c7fd8f786353451995e45ac1b82fb5c94efb4591825199fd926747168c78d640"

set[:nginx][:dir]                    = "/etc/nginx"
set[:nginx][:log_dir]                = "/var/log/nginx"
set[:nginx][:binary]                 = "/usr/sbin/nginx"

set[:nginx][:user]                   = "www-data"
default[:nginx][:worker_processes]   = cpu[:total] * 3
default[:nginx][:pid]                = "/var/run/nginx.pid"

default[:nginx][:worker_connections] = 1024
default[:nginx][:multi_accept]       = "off"

default[:nginx][:keepalive_timeout]             = 65
default[:nginx][:types_hash_max_size]           = 2048
default[:nginx][:server_tokens]                 = "off"
default[:nginx][:server_names_hash_bucket_size] = 64
default[:nginx][:server_name_in_redirect]       = "off"

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
  "text/html",
  "text/css",
  "text/javascript",
  "application/json",
  "application/x-javascript",
  "text/xml",
  "application/xml",
  "application/xml+rss"
]

# Optional Phusion Passenger module
default[:nginx][:passenger][:revision] = "1afc4dea90"
default[:nginx][:passenger][:url] = "http://virtmachine.s3.amazonaws.com/passenger/passenger-3.2.0.#{revision}.tgz"
default[:nginx][:passenger][:checksum] = "a6fcfc4b131d6a8d65166734b15bf501590565b7e9723335d9f3e8d5f51c4ec8"
default[:nginx][:passenger][:enabled] = true
default[:nginx][:passenger][:root] = "/usr/local/src/passenger"
default[:nginx][:passenger][:nginx_module_path] = File.join(nginx[:passenger][:root], 'ext/nginx')
default[:nginx][:passenger][:max_pool_size] = 25
