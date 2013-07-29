connect-rails
=============

A rails engine for interfacing with OpenStax's common services server.

Usage
-----

Add the engine to your Gemfile and then run `bundle install`.  

Mount the engine your application's `routes.rb` file:

    MyApplication::Application.routes.draw do
      ...
      mount OpenStax::Connect::Engine, at: "/connect"
      ...
     end

You can use whatever path you want instead of `/connect`, just make sure to make the appropriate changes below.

Create an `openstax_connect.rb` initializer in `config/initializers`, with the following contents:

    OpenStax::Connect.configure do |config|
      config.openstax_application_id = 'value_from_openstax_services_here'
      config.openstax_application_secret = 'value_from_openstax_services_here'
    end

If you're running OpenStax Services in a dev instance on your machine, you can specify that instance's local URL with:

    config.openstax_services_url = 'http://localhost:3000/'

To have users login, direct them to `/connect/auth/openstax`.  This is also available through the `openstax_connect.login` route helper, e.g. `<%= link_to 'Sign in!', openstax_connect.login_path %>`.
