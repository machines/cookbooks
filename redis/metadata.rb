maintainer        "Gerhard Lazu"
maintainer_email  "gerhard@lazu.co.uk"
license           "Apache 2.0"
description       "Installs and configures Redis 2.2.14"
version           "2.2.14"

recipe "redis::source", "Installs redis from source"

%w{ ubuntu debian }.each do |os|
  supports os
end
