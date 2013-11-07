module OpenStax
  module Connect
    module Dev
      class UsersController < DevController
        
        def login; end

        def search
          handle_with(Dev::UsersSearch,
                      complete: lambda { render 'search' })
        end

      end
    end
  end
end