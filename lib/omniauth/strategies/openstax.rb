require 'omniauth'
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Openstax < OAuth2
      option :name, "openstax"

      option :client_options, {
        :site => OpenStax::Connect.configuration.openstax_services_url,
        :authorize_url => "/oauth/authorize"
      }

      uid        { raw_info["uid"] }

      info do
        {
          username: raw_info["username"],
          first_name: raw_info["first_name"],
          last_name: raw_info["last_name"]
          # and anything else you want to return to your API consumers
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end
