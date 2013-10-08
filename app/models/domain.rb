class Domain
  
  # given a name, return root domain
  # www.strikingly.com  ==> strikingly.com 
  # x.y.z.strikingly.com ==> strikingly.com
  # news.sina.com.cn  ==> sina.com.cn
  def self.name_to_root_domain(name)
    a = name.split('.')

    # do not accept arbitary length name
    return nil if a.length > 20

    # form a domain and check it is valid or not
    # for example: news.sina.com.cn
    # 1) try com.cn
    # 2) try sina.com.cn
    # 3) return sina.com.cn
    a.reverse!
    s = a[0]
    (a.length - 1).times do |i|
      s = [a[i+1], s].join('.')
      begin
        Resolv.getaddress(s)
        # no exception happens, this is a valid root domain
        return s 
      rescue Resolv::ResolvError => e
        # just continue
      end      
    end
    nil
  end

end