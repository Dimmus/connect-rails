$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "openstax/connect/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "openstax_connect"
  s.version     = OpenStax::Connect::VERSION
  s.authors     = ["JP Slavinsky"]
  s.email       = ["jps@kindlinglabs.com"]
  s.homepage    = "http://github.com/openstax/connect-rails"
  s.summary     = "Rails common code and bindings and for 'services' API"
  s.description = "Rails common code and bindings and for 'services' API"

  s.files = Dir["{app,config,db,lib}/**/*", "spec/factories/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.14"
  s.add_dependency "omniauth", "~> 1.1"
  s.add_dependency "omniauth-oauth2", "~> 1.1.1"
  s.add_dependency "squeel"
  s.add_dependency "lev", "~> 2.0.1"
  s.add_dependency 'openstax_utilities', '~> 1.2.0'
  s.add_dependency 'sass-rails',   '~> 3.2.3'
  s.add_dependency 'coffee-rails', '~> 3.2.1'
  s.add_dependency 'uglifier', '>= 1.0.3'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'quiet_assets'
  s.add_development_dependency 'thin'
end
