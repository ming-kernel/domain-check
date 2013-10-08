class WhoisService
  def self.query(domain)
    domain = domain[4..-1] if domain.start_with?('www.')
    rsp = {}
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
    if r.registrar
      rsp['registrar'] = r.registrar.name   
      [nil, rsp]
    else
      ['InvalidDomain', {}]
    end
  end

end