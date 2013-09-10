require_dependency "openstax/connect/application_controller"

module OpenStax
  module Connect
    module Dev
      class DevController < ApplicationController

        before_filter Proc.new{ 
          raise SecurityTransgression unless !Rails.env.production? || 
                                             current_user.is_administrator? 
        }
        
      end
    end
  end
end