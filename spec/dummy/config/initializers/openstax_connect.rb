require 'capybara'

# Initializes a Capybara server running the Dummy app
CAPYBARA_SERVER = Capybara::Server.new(Rails.application).boot

OpenStax::Connect.configure do |config|
  config.openstax_accounts_url = "http://localhost:#{CAPYBARA_SERVER.port}/"
  config.openstax_application_id = 'secret'
  config.openstax_application_secret = 'secret'
  config.logout_via = :delete
end