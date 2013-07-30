require_dependency "openstax/connect/application_controller"

module OpenStax
  module Connect
    class SessionsController < ApplicationController

      def new
        session[:return_to] = request.referrer
        redirect_to openstax_login_url
      end

      def create
        auth = request.env['omniauth.auth']
        self.current_user = ProcessOmniauthAuthentication.exec(auth, current_user)
        redirect_to session.delete(:return_to) || main_app.root_url
      end

      def destroy
        self.current_user = nil
        redirect_to main_app.root_path, notice: "Signed out!"
      end

      def failure
        redirect_to main_app.root_path, alert: "Authentication failed, please try again."
      end

    end
  end
end
