require 'spec_helper'

describe HostService do
  it 'query strikingly.com should return valid rsp' do
    url = 'strikingly.com'
    err, rsp = HostService.query(url)
    err.should be_nil
    rsp.should eq({'domain' => 'strikingly.com',
      'a' => ['216.146.46.10', '216.146.46.11'],
      'cname' => [],
      'mx' => ['aspmx.l.google.com', 
        'alt1.aspmx.l.google.com',
        'alt2.aspmx.l.google.com',
        'aspmx2.googlemail.com',
        'aspmx3.googlemail.com']})
  end

  it 'www.strikingly.com should return valid rsp' do
    url = 'www.strikingly.com'
    err, rsp = HostService.query(url)
    err.should be_nil
    rsp.should eq({'domain' => 'strikingly.com',
      'a' => [],
      'cname' => ["kochi-3301.herokussl.com"],
      'mx' => []})
  end

  it 'sjfkljknckjnvjijoipj.com should return ' do
    url = 'sjfkljknckjnvjijoipj.com'
    err, rsp = HostService.query(url)
    err.should_not be_nil
    rsp.should eq({})
  end
end