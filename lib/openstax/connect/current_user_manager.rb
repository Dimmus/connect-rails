module OpenStax::Connect
  class CurrentUserManager

    # References:
    #   http://railscasts.com/episodes/356-dangers-of-session-hijacking

    def initialize(request, session, cookies)
      @request = request
      @session = session
      @cookies = cookies
    end

    # Returns the current app user
    def current_user
      refresh_current_users if @current_app_user.nil?
      @current_app_user
    end

    # Signs in the given user; the argument can be either a connect user or
    # an app user
    def sign_in(user)
      user.is_a?(User) ?
        self.connect_current_user = user :
        self.current_user = user
    end

    # Signs out the user
    def sign_out!
      sign_in(OpenStax::Connect::User.anonymous)
    end

    # Returns true iff there is a user signed in
    def signed_in?
      !connect_current_user.is_anonymous?
    end

  protected

    # Refreshes the current connect user (if needed) and returns it.
    def connect_current_user
      refresh_current_users if @connect_current_user.nil?
      @connect_current_user
    end  

    def refresh_current_users
      if @request.ssl? && @cookies.signed[:secure_user_id] != "secure#{@session[:user_id]}"
        sign_out! # hijacked
      else
        new_connect_current_user = @connect_current_user || User.anonymous
        new_connect_current_user = User.where(id: @session[:user_id]).first \
          if new_connect_current_user.is_anonymous? && @session[:user_id]

        # changes both current and app user
        self.connect_current_user = new_connect_current_user
      end
    end

    # Sets (signs in) the provided app user.
    def current_user=(user)
      self.connect_current_user = user_provider.app_user_to_connect_user(user)
      @current_app_user
    end

    # Sets the current connect user, updating the session and cookie state, also 
    # updates the cache of the current app user.
    def connect_current_user=(user)
      user ||= User.anonymous
      @connect_current_user ||= User.anonymous

      if user != @connect_current_user
        @connect_current_user = user
        @current_app_user = nil # changed connect user so invalidate the app user

        if @connect_current_user.is_anonymous?
          @session[:user_id] = nil
          @cookies.delete(:secure_user_id)
        else
          @session[:user_id] = @connect_current_user.id
          @cookies.signed[:secure_user_id] = {secure: true, value: "secure#{@connect_current_user.id}"}
        end
      end

      @current_app_user ||= user_provider.connect_user_to_app_user(@connect_current_user)
      @connect_current_user
    end

    def user_provider
      OpenStax::Connect.configuration.user_provider
    end

  end
end