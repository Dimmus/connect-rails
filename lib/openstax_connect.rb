require "openstax/connect/version"
require "openstax/connect/exceptions"
require "openstax/connect/engine"
require "openstax/connect/utilities"
require "openstax/connect/route_helper"
require "openstax/connect/action_list"
require "openstax/connect/user_provider"

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
        attr_accessor :security_transgression_exception

        # OpenStax Connect provides you with an OpenStax::Connect::User object.  You can
        # use this as your app's User object without modification, you can modify it to suit
        # your app's needs (not recommended), or you can provide your own custom User object
        # that references the OpenStax Connect User object.  
        #
        # OpenStax Connect also provides you methods for getting and setting the current 
        # signed in user (current_user and current_user= methods).  If you choose to create 
        # your own custom User object that references the User object provide by Connect, 
        # you can teach OpenStax Connect how to translate between your app's custom User 
        # object and OpenStax Connect's built-in User object.
        #
        # To do this, you need to set a "user_provider" in this configuration.  
        #
        #   config.user_provider = MyUserProvider
        #
        # The user_provider is a class that provides two class methods:
        #
        #   def self.connect_user_to_app_user(connect_user)
        #     # converts the given connect user to an app user
        #     # if you want to cache the connect_user in the app user
        #     # this is the place to do it.
        #   end
        #
        #   def self.app_user_to_connect_user(app_user)
        #     # converts the given app user to a connect user
        #   end 
        #
        # Connect users are never nil.  When a user is signed out, the current connect user 
        # is an anonymous user (responding true is "is_anonymous?").  You can follow the same
        # pattern in your app or you can use nil for the current user.  Just remember to check
        # the anonymous status of connect users when doing your connect <-> app translations.
        #
        # The default user_provider just uses OpenStax::Connect::User as the app user.
        attr_accessor :user_provider

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
          @default_errors_partial = 'openstax/connect/shared/attention'
          @default_errors_html_id = 'openstax-connect-attention'
          @default_errors_added_trigger = 'openstax-connect-errors-added'
          @security_transgression_exception = OpenStax::Connect::SecurityTransgression
          @user_provider = OpenStax::Connect::UserProvider
          super
        end

        def enable_stubbing?
          !Rails.env.production? && enable_stubbing
        end
      end

    end

  end
end
