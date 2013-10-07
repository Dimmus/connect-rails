require_dependency "openstax/connect/application_controller"

module OpenStax
  module Connect
    class SessionsController < ApplicationController

      skip_before_filter :authenticate_user!

      def new
        session[:return_to] = request.referrer
        redirect_to RouteHelper.get_path(:login)
      end

      def omniauth_authenticated
        handle_with(SessionsOmniauthAuthenticated,
                    complete: lambda { 
                      connect_sign_in(@handler_result.outputs[:connect_user_to_sign_in])
                      redirect_to return_path(true)
                    })
      end

      def destroy
        sign_out!
        redirect_to return_path, notice: "Signed out!"
      end

      def failure
        redirect_to return_path, alert: "Authentication failed, please try again."
      end

      def become
        raise SecurityTransgression unless !Rails.env.production? || current_user.is_administrator?
        sign_in(User.find(params[:user_id]))
        redirect_to return_path(true)
      end

    protected

      def return_path(include_referrer=false)
        referrer = include_referrer ? request.referrer : nil
        params[:return_to] || session.delete(:return_to) || referrer || main_app.root_path
      end

    end
  end
end
