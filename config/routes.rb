OpenStax::Connect::Engine.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create' #omniauth route
end
