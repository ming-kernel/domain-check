class WhoisService

  # given a name, return root domain
  # www.strikingly.com  ==> strikingly.com 
  # x.y.z.strikingly.com ==> strikingly.com
  # news.sina.com.cn  ==> sina.com.cn
  def self.root_domain(name)
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

  def self.query(name)
    domain = root_domain(name)
    return ['InvalidDomain', {}] if !domain

    rsp = {}

    # confirm to the 'whois' command line to not do referral
    c = Whois::Client.new(referral: false)
    begin
      r = c.lookup(domain)  
    rescue Whois::Error => e
      return ["#{e}", rsp]
    end
    
    rsp['domain'] = r.domain
    rsp['nameservers'] = []
    r.nameservers.each do |nameserver|
      rsp['nameservers'] << nameserver.name
    end

    # assume domain invalid if registrar is nil
    if r.registrar
      rsp['registrar'] = r.registrar.name   
      [nil, rsp]
    else
      ['InvalidDomain', {}]
    end
  end

end