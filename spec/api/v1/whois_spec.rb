require 'spec_helper'

describe "whois api" do

  endpoint = "api/v1/whois/%s"

  it 'google.com' do
    # get 'api/v1/whois/google.com'
    get(endpoint % 'google.com')
    response.should be_success
    json['response']['domain'].should == 'google.com'
    json['response']['nameservers'].length.should > 0
  end

  it 'strikingly.com and www.strikingly.com' do
    get(endpoint % 'strikingly.com')
    response.should be_success
    r1 = json['response']

    get 'api/v1/whois/www.strikingly.com'
    response.should be_success
    r2 = json['response']
    r1.should eq(r2)
  end

  it 'dijfoifkskfjjdoijfisjdklfnksljdfkljs.com' do
    get(endpoint % 'dijfoifkskfjjdoijfisjdklfnksljdfkljs.com')
    response.should be_not_found
  end

  it 'news.sina.com.cn and www.sina.com.cn' do
    get(endpoint % 'news.sina.com.cn')
    response.should be_success
  end

  it 'empty' do 
    get(endpoint % "\'\'")
    response.should be_not_found
  end

  
end