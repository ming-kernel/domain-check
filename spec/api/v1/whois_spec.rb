require 'spec_helper'

describe "whois api" do

  it 'google.com' do
    get 'api/v1/whois/google.com'
    response.should be_success
    json['response']['domain'].should == 'google.com'
    json['response']['nameservers'].length.should > 0
  end

  it 'strikingly.com and www.strikingly.com' do
    get 'api/v1/whois/strikingly.com'
    response.should be_success
    r1 = json['response']

    get 'api/v1/whois/www.strikingly.com'
    response.should be_success
    r2 = json['response']
    r1.should eq(r2)
  end

  it 'dijfoifkskfjjdoijfisjdklfnksljdfkljs.com' do
    get 'api/v1/whois/dijfoifkskfjjdoijfisjdklfnksljdfkljs.com'
    response.should be_not_found
  end

  it 'empty' do 
    get "api/v1/whois/''"
    response.should be_not_found
  end

  
end