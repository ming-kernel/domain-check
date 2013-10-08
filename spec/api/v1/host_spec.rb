require 'spec_helper'

describe "host api" do
  endpoint = "api/v1/host/%s"

  it 'google.com' do
    get(endpoint % 'google.com')
    response.should be_success
    json['response']['cname'].length.should == 0
    json['response']['a'].length > 0
    json['response']['mx'].length > 0
    json['response']['domain'].should == 'google.com'
  end

  it 'www.google.com' do
    get(endpoint % 'www.google.com')
    response.should be_success
    json['response']['cname'].length.should == 0
    json['response']['a'].length.should > 0
    json['response']['mx'].length.should == 0
    json['response']['domain'].should == 'google.com'
  end

  it 'dijfoifkskfjjdoijfisjdklfnksljdfkljs.com' do
    get(endpoint % 'dijfoifkskfjjdoijfisjdklfnksljdfkljs')
    expect(response).to be_not_found
  end

  it 'empty' do 
    get(endpoint % "\'\'")
    expect(response).to be_not_found
  end
 
end

