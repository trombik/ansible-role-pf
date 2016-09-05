require 'spec_helper'
require 'serverspec'

package = 'pf'
service = 'pf'
config  = '/etc/pf/pf.conf'
user    = 'pf'
group   = 'pf'
ports   = [ PORTS ]
log_dir = '/var/log/pf'
db_dir  = '/var/lib/pf'

case os[:family]
when 'freebsd'
  config = '/usr/local/etc/pf.conf'
  db_dir = '/var/db/pf'
end

describe package(package) do
  it { should be_installed }
end 

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape('pf') }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(db_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

case os[:family]
when 'freebsd'
  describe file('/etc/rc.conf.d/pf') do
    it { should be_file }
  end
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
