require "openstax/connect/engine"
require "openstax/connect/version"

require "omniauth/strategies/openstax"

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
        
        def initialize      
          @openstax_application_id = 'SET ME!'
          @openstax_application_secret = 'SET ME!'
          super
        end
      end

    end

  end
end
