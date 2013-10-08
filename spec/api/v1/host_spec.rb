require 'spec_helper'

describe "host api" do
  it 'google.com' do
    get 'api/v1/host/google.com'
    response.should be_success
    json['response']['cname'].length.should == 0
    json['response']['a'].length > 0
    json['response']['mx'].length > 0
    json['response']['domain'].should == 'google.com'
  end

  it 'www.google.com' do
    get 'api/v1/host/www.google.com'
    response.should be_success
    json['response']['cname'].length.should == 0
    json['response']['a'].length.should > 0
    json['response']['mx'].length.should == 0
    json['response']['domain'].should == 'google.com'
  end

  it 'dijfoifkskfjjdoijfisjdklfnksljdfkljs.com' do
    get 'api/v1/host/dijfoifkskfjjdoijfisjdklfnksljdfkljs.com'
    expect(response).to be_not_found
  end

  it 'empty' do 
    get "api/v1/host/''"
    expect(response).to be_not_found
  end
 
end

