include_recipe "grafana"

fail "Set a password! node['et_influxdb']['passsword']" unless node['et_influxdb']['password']

grafana_datasource 'influxdb-main' do
  source(
    type: 'influxdb_09',
    url: 'http://127.0.0.1:8086',
    access: 'proxy',
    database: 'metrics',
    user: 'dashboard',
    password: node['et_influxdb']['passsword'],
    isdefault: true
  )
end
