require 'spec_helper'

describe "whois api" do
  it 'google.com success' do
    get 'api/v1/whois/google.com'
    expect(response).to be_success
  end

  it 'dijfoifkskfjjdoijfisjdklfnksljdfkljs.com' do
    get 'api/v1/whois/dijfoifkskfjjdoijfisjdklfnksljdfkljs.com'
    expect(response).to be_not_found
  end

  it 'null url ' do 
    get "api/v1/whois/''"
    expect(response).to be_not_found
  end

  
end