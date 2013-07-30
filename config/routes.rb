OpenStax::Connect::Engine.routes.draw do
  match '/auth/openstax/callback', to: 'sessions#create' #omniauth route
  get '/auth/openstax', :as => 'openstax_login'
  get 'sessions/new', :as => 'login'
  
  # See https://github.com/plataformatec/devise/commit/f3385e96abf50e80d2ae282e1fb9bdad87a83d3c
  match 'sessions/destroy', :as => 'logout', :via => OpenStax::Connect.configuration.logout_via
end
