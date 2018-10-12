# vim: tabstop=2:shiftwidth=2:softtabstop=2
# Flag to set whether the HBase master restart process was successful or not
default['bcpc']['hadoop']['hbase_master']['restart_failed'] = false
# Attribute to save the time when HBase master restart process failed
default['bcpc']['hadoop']['hbase_master']['restart_failed_time'] = ''
# Flag to set whether the HBase region server restart process was successful or not
default['bcpc']['hadoop']['hbase_regionserver']['restart_failed'] = false
# Attribute to save the time when HBase region server restart process failed
default['bcpc']['hadoop']['hbase_regionserver']['restart_failed_time'] = ''
default['bcpc']['hadoop']['hbase']['root_dir'] = "#{node['bcpc']['hadoop']['hdfs_url']}/hbase"
default['bcpc']['hadoop']['hbase']['bulkload_staging_dir'] = '/tmp/hbase'
default['bcpc']['hadoop']['hbase']['repl']['enabled'] = false
default['bcpc']['hadoop']['hbase']['repl']['peer_id'] = node.chef_environment.tr('-', '_')
default['bcpc']['hadoop']['hbase']['repl']['target'] = ''
default['bcpc']['hadoop']['hbase']['superusers'] = ['hbase']
default['bcpc']['hadoop']['hbase']['cluster']['distributed'] = true
default['bcpc']['hadoop']['hbase']['defaults']['for']['version']['skip'] = true
default['bcpc']['hadoop']['hbase']['dfs']['client']['read']['shortcircuit']['buffer']['size'] = 131_072
default['bcpc']['hadoop']['hbase']['regionserver']['handler']['count'] = 128
# Interval in milli seconds when HBase major compaction need to be run. Disabled by default
default['bcpc']['hadoop']['hbase']['major_compact']['time'] = 0
default['bcpc']['hadoop']['hbase']['rsgroup']['enabled'] = false
default['bcpc']['hadoop']['hbase']['bucketcache']['enabled'] = false
default['bcpc']['hadoop']['hbase_rs']['coprocessor']['abortonerror'] = true
default['bcpc']['hadoop']['hbase']['blockcache']['size'] = 0.4
default['bcpc']['hadoop']['hbase']['bucketcache']['size'] = 1_434
default['bcpc']['hadoop']['hbase']['bucketcache']['ioengine'] = 'offheap'
default['bcpc']['hadoop']['hbase']['bucketcache']['combinedcache']['percentage'] = 0.71
default['bcpc']['hadoop']['hbase']['bucketcache.bucket.sizes'] = nil
default['bcpc']['hadoop']['hbase']['shortcircuit']['read'] = false
default['bcpc']['hadoop']['hbase']['region']['replica']['storefile']['refresh']['memstore']['multiplier'] = 4
default['bcpc']['hadoop']['hbase']['region']['replica']['wait']['for']['primary']['flush'] = true
default['bcpc']['hadoop']['hbase']['hregion']['memstore']['block']['multiplier'] = 8
default['bcpc']['hadoop']['hbase']['ipc']['client']['specificthreadforwriting'] = true
default['bcpc']['hadoop']['hbase']['client']['primarycalltimeout']['get'] = 100_000
default['bcpc']['hadoop']['hbase']['client']['primarycalltimeout']['multiget'] = 100_000
default['bcpc']['hadoop']['hbase']['meta']['replica']['count'] = 3
default['bcpc']['hadoop']['hbase']['ipc']['warn']['response']['time'] = 250
default['bcpc']['hadoop']['hbase']['ipc']['warn']['response']['size'] = 1_048_576
default['bcpc']['hadoop']['hbase']['ipc']['server_call_queue_handler_factor'] = 0.1
default['bcpc']['hadoop']['hbase']['ipc']['server_call_queue_read_ratio'] = 0
default['bcpc']['hadoop']['hbase']['ipc']['server_call_queue_scan_ratio'] = 0
default['bcpc']['hadoop']['hbase_master']['hfilecleaner']['ttl'] = 3_600_000
default['bcpc']['hadoop']['hbase_master']['jmx']['port'] = 10101
default['bcpc']['hadoop']['hbase_master']['gc_thread']['cpu_ratio'] = 0.2
default['bcpc']['hadoop']['hbase_master']['cmsinitiatingoccupancyfraction'] = 70
default['bcpc']['hadoop']['hbase_master']['PretenureSizeThreshold'] = '1m'
default['bcpc']['hadoop']['hbase_master']['xmn']['size'] = 256
default['bcpc']['hadoop']['hbase_master']['xms']['size'] = 1_024
default['bcpc']['hadoop']['hbase_master']['xmx']['size'] = 1_024
default['bcpc']['hadoop']['hbase_master']['mx_dir_mem']['size'] = 256
default['bcpc']['hadoop']['hbase_master']['http']['port'] = 16010
default['bcpc']['hadoop']['hbase_rs']['http']['port'] = 60300
default['bcpc']['hadoop']['hbase_rs']['jmx']['port'] = 10102
default['bcpc']['hadoop']['hbase_rs']['xmn']['size'] = 256
default['bcpc']['hadoop']['hbase_rs']['xms']['size'] = 1_024
default['bcpc']['hadoop']['hbase_rs']['xmx']['size'] = 1_024
default['bcpc']['hadoop']['hbase_rs']['mx_dir_mem']['size'] = 256
default['bcpc']['hadoop']['hbase_rs']['hdfs_dir_mem']['size'] = 128
default['bcpc']['hadoop']['hbase_rs']['gc_thread']['cpu_ratio'] = 0.4
default['bcpc']['hadoop']['hbase_rs']['memstore']['upperlimit'] = 0.4
default['bcpc']['hadoop']['hbase_rs']['memstore']['lowerlimit'] = 0.2
default['bcpc']['hadoop']['hbase_rs']['storefile']['refresh']['all'] = false
default['bcpc']['hadoop']['hbase_rs']['storefile']['refresh']['period'] = 30_000
default['bcpc']['hadoop']['hbase_rs']['cmsinitiatingoccupancyfraction'] = 70
default['bcpc']['hadoop']['hbase_rs']['PretenureSizeThreshold'] = '1m'

# Apache Phoenix related attributes
default['bcpc']['hadoop']['phoenix']['tracing']['enabled'] = false

# These will become key/value pairs in 'hbase_site.xml'
default[:bcpc][:hadoop][:hbase][:site_xml].tap do |site_xml|
  site_xml['hbase.rootdir'] = node['bcpc']['hadoop']['hbase']['root_dir'].to_s
  site_xml['hbase.bulkload.staging.dir'] = node['bcpc']['hadoop']['hbase']['bulkload_staging_dir'].to_s
  site_xml['hbase.fs.tmp.dir'] = '/user/${user.name}/hbase-staging'
  site_xml['hbase.cluster.distributed'] = node['bcpc']['hadoop']['hbase']['cluster']['distributed'].to_s
  site_xml['hbase.quota.enabled'] = 'true'
  site_xml['hbase.hregion.majorcompaction'] = node['bcpc']['hadoop']['hbase']['major_compact']['time'].to_s
  site_xml['hbase.defaults.for.version.skip'] = node['bcpc']['hadoop']['hbase']['defaults']['for']['version']['skip'].to_s
  site_xml['hbase.regionserver.wal.codec'] = 'org.apache.hadoop.hbase.regionserver.wal.IndexedWALEditCodec'
  site_xml['hbase.region.server.rpc.scheduler.factory.class'] = 'org.apache.hadoop.hbase.ipc.PhoenixRpcSchedulerFactory'
  site_xml['hbase.rpc.controllerfactory.class'] = 'org.apache.hadoop.hbase.ipc.controller.ServerRpcControllerFactory'
  site_xml['hbase.regionserver.handler.count'] = node['bcpc']['hadoop']['hbase']['regionserver']['handler']['count'].to_s
  site_xml['hbase.ipc.warn.response.time'] = node['bcpc']['hadoop']['hbase']['ipc']['warn']['response']['time'].to_s
  site_xml['hbase.ipc.warn.response.size'] = node['bcpc']['hadoop']['hbase']['ipc']['warn']['response']['size'].to_s
  site_xml['hbase.ipc.server.tcpnodelay'] = 'true'
  site_xml['hbase.ipc.server.callqueue.handler.factor'] = node['bcpc']['hadoop']['hbase']['ipc']['server_call_queue_handler_factor']
  site_xml['hbase.ipc.server.callqueue.read.ratio'] = node['bcpc']['hadoop']['hbase']['ipc']['server_call_queue_read_ratio']
  site_xml['hbase.ipc.server.callqueue.scan.ratio'] = node['bcpc']['hadoop']['hbase']['ipc']['server_call_queue_scan_ratio']
  site_xml['hbase.replication'] = 'true'
  site_xml['hbase.master.loadbalance.bytable'] = true
  site_xml['hbase.coprocessor.abortonerror'] = node['bcpc']['hadoop']['hbase_rs']['coprocessor']['abortonerror']
  site_xml['hbase.master.balancer.stochastic.tableSkewCost'] = 3000
  site_xml['hbase.master.balancer.stochastic.localityCost'] = 1000
  site_xml['hbase.region.replica.replication.enabled'] = false
  site_xml['hbase.coprocessor.region.whitelist.paths'] = ''
  site_xml['phoenix.schema.isNamespaceMappingEnabled'] = true
  site_xml['phoenix.schema.mapSystemTablesToNamespace'] = true
end

# hbase_env attributes
default['bcpc']['hadoop']['hbase']['env'] = {}
default['bcpc']['hadoop']['hbase']['env']['master_java_agents'] = []
default['bcpc']['hadoop']['hbase']['env']['regionserver_java_agents'] = []

# hbase bach web attributes
default['bcpc']['bach_web']['services']['hbase'] = {
  'desc' => 'HBase Master',
  'port' => node['bcpc']['hadoop']['hbase_master']['http']['port'],
  'conn_lib' => {
    'blacklist' => [
      'hadoop.security.group.mapping.ldap.bind.password.file',
      'hbase.master.hostname'
    ],
    'whitelist' => nil
  }
}

# haproxy
default['bcpc']['haproxy']['ha_services'] += [{
  'name' => 'hbase_master',
  'port' => node['bcpc']['hadoop']['hbase_master']['http']['port'],
  'http_check_url' => '/jmx',
  'http_check_expect_str' => '"tag.isActiveMaster"\ :\ "true"',
  # FIXME: should be replaced by static parsing of cluster.txt
  #        but before the node search is eliminated, use the target recipe to find servers
  #'servers' => [ { 'fqdn' => 'xxx', 'ip' => 'xxx', 'port' => 'xxx' }, ...]
  'servers_recipes_in_cookbooks' => [{'cookbook' => 'bcpc-hadoop', 'recipe' => 'hbase_master'}],
  'servers_port' => node['bcpc']['hadoop']['hbase_master']['http']['port']
}]
