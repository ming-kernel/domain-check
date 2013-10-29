class WhoisService

  def self.get_result(name)
    Sidekiq.redis do |c|
      redis_result = c.get(name)
      if nil == redis_result
        return [nil, nil]
      else
        result = JSON.parse(redis_result)
        puts result
        err = result['error']
        rsp = result['rsp']
        return [err, rsp]
      end
    end
  end

  def self.query(name)
    err, rsp = get_result(name)
    if err == nil and rsp == nil
      WhoisWorker.perform_async('whois', name)
      return [nil, nil]
    else
      return [err, rsp]
    end
    
    # domain = Domain.name_to_root_domain(name)
    # return ['InvalidDomain', {}] if !domain

    # rsp = {}

    # # confirm to the 'whois' command line to not do referral
    # c = Whois::Client.new(referral: false)
    # begin
    #   r = c.lookup(domain)  
    # rescue Whois::Error => e
    #   return ["#{e}", rsp]
    # end
    
    # rsp['domain'] = r.domain
    # rsp['nameservers'] = []
    # r.nameservers.each do |nameserver|
    #   rsp['nameservers'] << nameserver.name
    # end

    # # assume domain invalid if registrar is nil
    # if r.registrar
    #   rsp['registrar'] = r.registrar.name   
    #   [nil, rsp]
    # else
    #   ['InvalidDomain', {}]
    # end
  end

end