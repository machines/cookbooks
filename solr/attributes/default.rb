include_attribute "jetty"

expand!

default[:solr][:version]   = "3.5.0"
default[:solr][:link]      = "http://www.bizdirusa.com/mirrors/apache/lucene/solr/#{solr.version}/apache-solr-#{solr.version}.tgz"
default[:solr][:checksum]  = "804f3ba9d1296f81388605a79538b7362355693fbdd03b7b2dbf9a706bf1d1d0"
default[:solr][:directory] = "/usr/local/src"
default[:solr][:download]  = "#{solr.directory}/apache-solr-#{solr.version}.tgz"
default[:solr][:extracted] = "#{solr.directory}/apache-solr-#{solr.version}"
default[:solr][:war]       = "#{solr.extracted}/dist/apache-solr-#{solr.version}.war"

default[:solr][:context_path] = "solr"
default[:solr][:home]         = "/mnt/#{node.solr.context_path}"
default[:solr][:data]         = "/mnt/#{node.solr.context_path}/data"
