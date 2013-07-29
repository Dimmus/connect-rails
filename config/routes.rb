OpenStax::Connect::Engine.routes.draw do
  match '/auth/openstax/callback', to: 'sessions#create' #omniauth route
  get '/auth/openstax', :as => 'login'
end
