require 'spec_helper'

describe "whois api" do

  it 'google.com' do
    get 'api/v1/whois/google.com'
    response.should be_success
    json['response']['domain'].should == 'google.com'
    json['response']['nameservers'].length.should > 0
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