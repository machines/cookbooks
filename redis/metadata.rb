maintainer        "Machines.io"
maintainer_email  "support@machines.io"
license           "Apache 2.0"
description       "Installs and configures Redis 2.6.0"
version           "2.6.0"

recipe "redis::source", "Installs redis from source"

%w{ ubuntu debian }.each do |os|
  supports os
end
