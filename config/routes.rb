DomainCheck::Application.routes.draw do
  resources :posts

  get "whois", to: 'whois#new'
  

  # Whois api
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :whois, only: [:show], constraints: {id: /[^\/]+/}
      resources :host, only: [:show], constraints: {id: /[^\/]+/}        
    end
  end
end
