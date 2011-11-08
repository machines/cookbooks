include_attribute "jetty"

expand!

default[:solr][:version]   = "3.4.0"
default[:solr][:link]      = "http://www.bizdirusa.com/mirrors/apache/lucene/solr/#{solr.version}/apache-solr-#{solr.version}.tgz"
default[:solr][:checksum]  = "6a5d2304c7e84a6ce340d0e5aa0fa3a25484e9df0f7f92c17ce7b483aa04a6c7"
default[:solr][:directory] = "/usr/local/src"
default[:solr][:download]  = "#{solr.directory}/apache-solr-#{solr.version}.tgz"
default[:solr][:extracted] = "#{solr.directory}/apache-solr-#{solr.version}"
default[:solr][:war]       = "#{solr.extracted}/dist/apache-solr-#{solr.version}.war"

default[:solr][:context_path] = "solr"
default[:solr][:home]         = "/mnt/#{node.solr.context_path}"
default[:solr][:data]         = "/mnt/#{node.solr.context_path}/data"
