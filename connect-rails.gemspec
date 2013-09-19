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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "omniauth", "~> 1.1"
  s.add_dependency "omniauth-oauth2", "~> 1.1.1"
  s.add_dependency "squeel"
  s.add_dependency "lev", "~> 0.0.3"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
