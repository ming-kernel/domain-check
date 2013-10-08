class WhoisService

  def self.query(name)
    domain = Domain.name_to_root_domain(name)
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