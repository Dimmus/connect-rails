ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym 'OpenStax'
end

require 'omniauth'

module OpenStax
  module Connect
    class Engine < ::Rails::Engine
      isolate_namespace OpenStax::Connect

      config.generators do |g|
        g.test_framework :rspec, :view_specs => false
      end

      # Doesn't work to put this omniauth code in an engine initializer, instead:
      # https://gist.github.com/pablomarti/5243118
      middleware.use ::OmniAuth::Builder do
        provider :openstax, 
           OpenStax::Connect.configuration.openstax_application_id,
           OpenStax::Connect.configuration.openstax_application_secret
        end
    end
  end
end
