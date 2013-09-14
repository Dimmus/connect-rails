module OpenStax
  module Connect
    module Dev
      class UsersController < DevController

        def index; end
        
        def create
          handle_with(Dev::UsersCreate,
                      success: lambda { redirect_to dev_users_path, notice: 'Success!'},
                      failure: lambda { render 'index', alert: 'Error' })
        end

        def generate
          handle_with(Dev::UsersGenerate,
                      success: lambda { redirect_to dev_users_path, notice: 'Success!'},
                      failure: lambda { render 'index', alert: 'Error' })
        end

        def sign_in
        end

        def search
          handle_with(Dev::UsersSearch,
                      complete: lambda { render 'search' })
        end

      end
    end
  end
end