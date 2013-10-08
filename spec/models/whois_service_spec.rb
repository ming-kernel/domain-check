require 'spec_helper'

describe WhoisService do
  it 'query strikingly.com should return valid rsp for strikingly.com' do
    domain = 'strikingly.com'
    err, rsp = WhoisService.query(domain)
    err.should be_nil
    rsp.should eq({'domain' => domain,
      'registrar' => 'ENOM, INC.',
      'nameservers' => ['ns1.p27.dynect.net', 'ns2.p27.dynect.net', 'ns3.p27.dynect.net', 'ns4.p27.dynect.net']
      })
  end

  it 'query www.strikingly.com should return valid rsp' do
    domain = 'strikingly.com'
    url = 'www.strikingly.com'
    err, rsp = WhoisService.query(url)
    err.should be_nil
    rsp.should eq({'domain' => domain,
      'registrar' => 'ENOM, INC.',
      'nameservers' => ['ns1.p27.dynect.net', 'ns2.p27.dynect.net', 'ns3.p27.dynect.net', 'ns4.p27.dynect.net']
      })
  end

  it 'query www.www.strikingly.com should return invalid rsp' do
    domain = 'strkingly.com'
    url = 'www.www.strikingly.com'
    err, rsp = WhoisService.query(url)
    err.should_not be_nil
  end

  it 'query empty should return invalid rsp' do
    url = ''
    err, rsp = WhoisService.query(url)
    err.should_not be_nil
  end

end
