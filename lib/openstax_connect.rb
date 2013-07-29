require "openstax/connect/engine"
require "openstax/connect/version"

module OpenStax
  module Connect

    class << self

      ###########################################################################
      #
      # Configuration machinery.
      #
      # To configure OpenStax Utilities, put the following code in your applications 
      # initialization logic (eg. in the config/initializers in a Rails app)
      #
      #   OpenStax::Connect.configure do |config|
      #     config.<parameter name> = <parameter value>
      #     ...
      #   end
      #
      
      def configure
        yield configuration
      end

      def configuration
        @configuration ||= Configuration.new
      end

      class Configuration
        attr_accessor :openstax_application_id
        attr_accessor :openstax_application_secret
        attr_reader :openstax_services_url

        def openstax_services_url=(url)
          url.gsub!(/https|http/,'https') if !(url =~ /localhost/)
          url = url + "/" if url[url.size-1] != '/'
          @openstax_services_url = url
        end

        def initialize      
          @openstax_application_id = 'SET ME!'
          @openstax_application_secret = 'SET ME!'
          @openstax_services_url = 'https://services.openstax.org/'
          super
        end
      end

    end

  end
end
