OpenStax::Connect::Engine.routes.draw do
  match '/auth/openstax/callback', to: 'sessions#omniauth_authenticated' #omniauth route
  get '/auth/openstax', :as => 'openstax_login'
  get 'sessions/new', :as => 'login'
  post 'sessions/become'
  
  # See https://github.com/plataformatec/devise/commit/f3385e96abf50e80d2ae282e1fb9bdad87a83d3c
  match 'sessions/destroy', :as => 'logout', :via => OpenStax::Connect.configuration.logout_via

  if OpenStax::Connect.configuration.enable_stubbing?
    namespace :dev do
      # get 'sessions/new'
      # post 'sessions/create'
      # post 'sessions/search'
      get 'users', to: 'users#index'
      post 'users/create'
      post 'users/generate'
      post 'users/search'
    end
  end
end


module OpenStax
  module Connect
    hh = Engine.routes.url_helpers

    RouteHelper.register_path(:login, hh.openstax_login_path) { hh.dev_users_path }
  end
end


