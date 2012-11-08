#
# Cookbook Name:: rhn
# Recipe:: default
#
# Copyright 2012
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
#

directory "/usr/local/src/rhn_setup" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "/usr/local/src/rhn_setup/bootstrap.sh" do
  source "bootstrap.sh.erb"
  owner  "root"
  group  "root"
  mode   "0755"
end

execute "RHN Bootstrapping to #{node['rhn']['hostname']}" do
  cwd Chef::Config[:file_cache_path]
  command "/usr/local/src/rhn_setup/bootstrap.sh"
  not_if "grep -q #{node['hostname']} /etc/sysconfig/rhn/systemid"
end
