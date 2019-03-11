Rails.application.routes.draw do

  resources :model,     controller: 'gatekeeper'

end
