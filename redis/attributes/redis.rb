default[:redis][:version]   = "2.6.10"
default[:redis][:checksum]  = "0b930976830afaad40274107a36f9aae0d8a8fbbdea4e566d20765ee502c2a22"
default[:redis][:dir]       = "redis-#{redis.version}"
default[:redis][:source]    = "http://redis.googlecode.com/files/#{redis.dir}.tar.gz"
default[:redis][:srcdir]    = "/usr/local/src"
default[:redis][:configdir] = "/etc/redis"

default[:redis][:port]      = 6379
default[:redis][:datadir]   = "/var/db/redis/#{redis.port}"
default[:redis][:config]    = "#{redis.configdir}/#{redis.port}.conf"
default[:redis][:logfile]   = "/var/log/redis_#{redis.port}.log"
default[:redis][:pidfile]   = "/var/run/redis_#{redis.port}.pid"
default[:redis][:init]      = "upstart"
default[:redis][:daemonize] = "no"

default[:redis][:timeout]     = 300
default[:redis][:databases]   = 16
default[:redis][:maxmemory]   = 0
default[:redis][:snapshots]   = {
  900 => 1,
  300 => 10,
  60  => 10000
}

default[:redis][:dbfilename]                  = "dump.rdb"
default[:redis][:stop_writes_on_bgsave_error] = "yes"
default[:redis][:rdbcompression]              = "yes"
default[:redis][:rdbchecksum]                 = "yes"
default[:redis][:bind]                        = false
default[:redis][:unixsocket]                  = false
default[:redis][:loglevel]                    = "notice"

default[:redis][:syslog_enabled]              = false
default[:redis][:syslog_ident]                = "redis"
default[:redis][:syslog_facility]             = "local0"

default[:redis][:slaveof]                     = false
default[:redis][:password]                    = false
default[:redis][:slave_serve_stale_data]      = "yes"
default[:redis][:slave_read_only]             = "yes"

default[:redis][:maxmemory_policy]            = "volatile-lru"
default[:redis][:maxmemory_samples]           = 3

default[:redis][:appendonly]                  = "no"
default[:redis][:appendfilename]              = "appendonly.aof"
default[:redis][:appendfsync]                 = "everysec"
default[:redis][:no_appendfsync_on_rewrite]   = "no"

default[:redis][:command_renames]             = {}

default[:redis][:hash_max_ziplist_entries]    = 512
default[:redis][:hash_max_ziplist_value]      = 64
default[:redis][:list_max_ziplist_entries]    = 512
default[:redis][:list_max_ziplist_value]      = 64
default[:redis][:set_max_intset_entries]      = 512
default[:redis][:zset_max_ziplist_entries]    = 128
default[:redis][:zset_max_ziplist_value]      = 64
default[:redis][:activerehashing]             = "yes"
