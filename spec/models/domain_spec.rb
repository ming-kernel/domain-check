require 'spec_helper'

describe Domain do

  it 'news.sina.com.cn ==> sina.com.cn' do
    name = 'news.sina.com.cn'
    domain = Domain.name_to_root_domain(name)
    domain.should == 'sina.com.cn'
  end

  it 'www.strikingly.com ==> strikingly.com' do
    name = 'www.strikingly.com'
    domain = Domain.name_to_root_domain(name)
    domain.should == 'strikingly.com'
  end
end