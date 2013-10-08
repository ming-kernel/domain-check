require 'spec_helper'

describe "host api" do
  it 'google.com success' do
    get 'api/v1/host/google.com'
    expect(response).to be_success
  end

  it 'dijfoifkskfjjdoijfisjdklfnksljdfkljs.com' do
    get 'api/v1/host/dijfoifkskfjjdoijfisjdklfnksljdfkljs.com'
    expect(response).to be_not_found
  end

  it 'null url ' do 
    get "api/v1/host/''"
    expect(response).to be_not_found
  end

  
end

