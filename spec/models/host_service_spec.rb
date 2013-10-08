require 'spec_helper'

describe HostService do
  it 'strikingly.com' do
    url = 'strikingly.com'
    err, rsp = HostService.query(url)
    err.should be_nil
    rsp['domain'].should == url
    rsp['a'].length.should ==  2
    rsp['cname'].length.should == 0
    rsp['mx'].length.should == 5
  end

  it 'www.strikingly.com' do
    url = 'www.strikingly.com'
    err, rsp = HostService.query(url)
    err.should be_nil
    rsp['domain'].should == 'strikingly.com'
    rsp['a'].length.should == 0
    rsp['cname'].length.should == 1
    rsp['mx'].length.should == 0
  end

  it 'sjfkljknckjnvjijoipj.com' do
    url = 'sjfkljknckjnvjijoipj.com'
    err, rsp = HostService.query(url)
    err.should_not be_nil
    rsp.should eq({})
  end

  it 'www.google.com' do
    url = 'www.google.com'
    err, rsp = HostService.query(url)
    err.should be_nil
    rsp["a"].length.should > 0
  end

  it 'empty' do
    url = ''
    err, rsp = HostService.query(url)
    err.should_not be_nil
    rsp.should eq({})
  end
end