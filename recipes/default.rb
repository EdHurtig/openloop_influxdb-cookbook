#
# Cookbook Name:: et_influxdb
# Recipe:: default
#
# Copyright 2015 Evertrue, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

influxdb 'main' do
  source node[:influxdb][:source]
  checksum node[:influxdb][:checksum]
  config node[:influxdb][:config] # Or if >=  0.9.x it will use node[:influxdb][:zero_nine][:config]
  action :create
end

influxdb_admin 'admin' do
  password node['et_influxdb']['password']
  not_if { node['et_influxdb']['password'].empty? }
end


influxdb_database 'grafana'

influxdb_retention_policy "foodb default retention policy" do
  policy_name 'default'
  database    'grafana'
  duration    '1w'
  replication 1
end
