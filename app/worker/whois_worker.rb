# app/workers/whois_worker.rb
class WhoisWorker
  include Sidekiq::Worker

  def start(url_name)
  	Sidekiq.redis do |c|
  		c.set(url_name, {:error => nil, :rsp => nil}.to_json) if c.get(url_name) == nil
  	end
  end

  def invalid_result(url_name, error_str)
  	Sidekiq.redis do |c|
  		c.set(url_name, {:error => error_str, :rsp => nil}.to_json)
  	end
  end

  def valid_result(url_name, rsp)
  	Sidekiq.redis do |c|
  		c.set(url_name, {:error => nil, :rsp => rsp}.to_json)
  	end
  end

  def perform(name, url_name)
  	# name is "whois"
  	
  	start(url_name)

  	domain = Domain.name_to_root_domain(url_name)

    if !domain
	    invalid_result(url_name, 'invalid_domain') 
	    return
    end

    rsp = {}

    # confirm to the 'whois' command line to not do referral
    c = Whois::Client.new(referral: false)
    begin
      r = c.lookup(domain)  
    rescue Whois::Error => e
    	invalid_result(url_name, "#{e}")
      return
    end
    
    rsp['domain'] = r.domain
    rsp['nameservers'] = []
    r.nameservers.each do |nameserver|
      rsp['nameservers'] << nameserver.name
    end

    # assume domain invalid if registrar is nil
    if r.registrar
      rsp['registrar'] = r.registrar.name   
      valid_result(url_name, rsp)
      return
    else
      invalid_result(url_name, invalid_domain)
      return
    end
	end
end