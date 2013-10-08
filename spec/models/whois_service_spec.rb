require 'spec_helper'

describe WhoisService do

  it 'news.sina.com.cn ==> sina.com.cn' do
    name = 'news.sina.com.cn'
    domain = WhoisService.root_domain(name)
    domain.should == 'sina.com.cn'
  end

  it 'www.strikingly.com ==> strikingly.com' do
    name = 'www.strikingly.com'
    domain = WhoisService.root_domain(name)
    domain.should == 'strikingly.com'
  end

  it 'strikingly.com' do
    domain = 'strikingly.com'
    err, rsp = WhoisService.query(domain)
    err.should be_nil
    rsp['domain'].should == domain
    rsp['registrar'].should == 'ENOM, INC.'
    rsp['nameservers'].length.should > 0
  end

  it 'www.strikingly.com' do
    domain = 'strikingly.com'
    url = 'www.strikingly.com'
    err, rsp = WhoisService.query(url)
    err.should be_nil
    rsp['domain'].should == 'strikingly.com'
    rsp['registrar'].should == 'ENOM, INC.'
    rsp['nameservers'].length.should > 0
  end


  it 'empty' do
    url = ''
    err, rsp = WhoisService.query(url)
    err.should_not be_nil
    rsp.should eq({})
  end

  it 'jdifjklsdjflksjfdcijojl.com' do
    err, rsp = WhoisService.query('jdifjklsdjflksjfdcijojl.com')
    err.should_not be_nil
    rsp.should eq({})
  end

end
