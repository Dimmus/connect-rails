require "openstax/connect/engine"
require "openstax/connect/version"
require "openstax/connect/utilities"
require "openstax/connect/route_helper"

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
      # Set enable_stubbing to true iff you want this engine to fake all 
      #   interaction with the services site.
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
        attr_accessor :enable_stubbing
        attr_reader :openstax_services_url
        attr_accessor :logout_via
        attr_accessor :default_errors_partial
        attr_accessor :default_errors_html_id
        attr_accessor :default_errors_added_trigger

        def openstax_services_url=(url)
          url.gsub!(/https|http/,'https') if !(url =~ /localhost/)
          url = url + "/" if url[url.size-1] != '/'
          @openstax_services_url = url
        end

        def initialize      
          @openstax_application_id = 'SET ME!'
          @openstax_application_secret = 'SET ME!'
          @openstax_services_url = 'https://services.openstax.org/'
          @enable_stubbing = true
          @logout_via = :get
          @default_error_partial = 'openstax/connect/shared/attention'
          @default_error_html_id = 'openstax-connect-attention'
          @default_errors_added_trigger = 'openstax-connect-errors-added'
          super
        end

        def enable_stubbing?
          !Rails.env.production? && enable_stubbing
        end
      end

    end

  end
end
