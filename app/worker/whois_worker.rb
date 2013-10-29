# app/workers/whois_worker.rb
class WhoisWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing hard work'
  end
end