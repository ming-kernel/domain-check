DomainCheck::Application.routes.draw do
  resources :whois, only: [:show], constraints: {id: /[^\/]+/}
  resources :host, only: [:show], constraints: {id: /[^\/]+/}
end
