require 'spec_helper'
require 'serverspec'

config  = '/etc/pf.conf'

describe file(config) do
  it { should be_mode 600 }
  it { should be_file }
  its(:content) { should match /^pass\s+#/ }
  its(:content) { should match Regexp.escape('block return in on ! lo0 proto tcp to port 6000:6010') }
end
