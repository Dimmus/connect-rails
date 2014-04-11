require 'uri'
require 'oauth2'

module OpenStax::Connect
  class Accounts
    # TODO: Maybe abstract some of this into openstax_api

    # Creates an ApplicationUser in Accounts for this app and the given user
    # Takes an optional API version parameter
    # Returns an OAuth2::Response object
    def self.create_application_user(user, version = nil)
      options = {:api_version => (version.nil? ? :v1 : version)}
      api_call(user, :post, 'application_users', options)
    end

    # Executes an OpenStax Accounts API call for the given user,
    # using the given HTTP method, API url and request options
    # Any options accepted by OAuth2 requests can be used, such as
    # :params, :body, :headers, etc.
    # On failure, it can throw Faraday::ConnectionFailed for connection errors
    # or OAuth2::Error if Accounts returns an HTTP 400 error,
    # such as 422 Unprocessable Entity
    # Returns an OAuth2::Response object
    def self.api_call(user, http_method, url, options = {})
      version = options.delete(:api_version)
      unless version.blank?
        options[:headers] ||= {}
        options[:headers].merge!({ 'Accept' => "application/vnd.accounts.openstax.#{version.to_s}" })
      end

      token = OAuth2::AccessToken.new(client, user.access_token)
      api_url = URI.join(config.openstax_accounts_url, 'api/', url)

      token.request(http_method, api_url, options)
    end

  protected

    def self.config
      OpenStax::Connect.configuration
    end

    def self.client
      @client ||= OAuth2::Client.new(config.openstax_application_id,
                                     config.openstax_application_secret,
                                     :site => config.openstax_accounts_url)
    end

  end
end