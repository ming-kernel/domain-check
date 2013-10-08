class HostService
  def self.query(url)
    
    # validates url
    begin
      Resolv.getaddress url  
    rescue Resolv::ResolvError => e
      return ["#{e}", {}]  
    end
    
    if url.start_with?('www.') 
      domain = url[4..-1]
    else
      domain = url
    end

    rsp = {}
    resolver = Resolv::DNS.new
    
    # cname sorted by name
    rsp['cname'] = []
    cname = resolver.getresources url, Resolv::DNS::Resource::IN::CNAME
    cname.sort! {|x, y| x.name.to_s <=> y.name.to_s }
    cname.each do |c|
      rsp['cname'] << c.name.to_s

    end

    # A record sorted by address name
    # do not fetch A record if cname exists 
    rsp['a'] = []
    if rsp['cname'].length == 0
      a = resolver.getresources url, Resolv::DNS::Resource::IN::A
      a.sort! {|x, y| x.address.to_s <=> y.address.to_s }
      a.each do |x|
        rsp['a'] << x.address.to_s
      end
    end

    # mx record sorted by preference
    rsp['mx'] = []
    mx = resolver.getresources url, Resolv::DNS::Resource::IN::MX
    mx.sort! {|x, y| x.preference <=> y.preference}
    mx.each do |m|
      rsp['mx'] << m.exchange.to_s
    end

    rsp['domain'] = domain
    [nil, rsp]
  end
end