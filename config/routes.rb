DomainCheck::Application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :whois, only: [:show], constraints: {id: /[^\/]+/}
      resources :host, only: [:show], constraints: {id: /[^\/]+/}        
    end
  end
end
