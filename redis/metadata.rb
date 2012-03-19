maintainer        "Gerhard Lazu"
maintainer_email  "gerhard@lazu.co.uk"
license           "Apache 2.0"
description       "Installs and configures Redis 2.4.9"
version           "2.4.9"

recipe "redis::source", "Installs redis from source"

%w{ ubuntu debian }.each do |os|
  supports os
end
