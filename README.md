connect-rails
=============

Usage
-----

1. Add this engine to your Gemfile
2. Run `bundle install`
3. Mount the engine in your `routes.rb` file.  

       MyApplication::Application.routes.draw do
         ...
         mount OpenStax::Connect::Engine, at: "/connect"
         ...
        end

    You can use whatever path you want instead of `/connect`.

4. Create an `openstax_connect.rb` initializer in `config/initializers`, with the following contents:

        OpenStax::Connect.configure do |config|
          config.openstax_application_id = 'value_from_openstax_services_here'
          config.openstax_application_secret = 'value_from_openstax_services_here'
        end

5. To have users login, direct them to `/connect/auth/openstax'.
