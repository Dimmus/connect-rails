class ActionController::Base
  # References:
  #   http://railscasts.com/episodes/356-dangers-of-session-hijacking

  # Returns the current app user
  def current_user
    current_connect_user
    @current_app_user
  end

  # Quasi "private" method that returns the current connect user, refreshing it if needed
  def current_connect_user
    if request.ssl? && cookies.signed[:secure_user_id] != "secure#{session[:user_id]}"
      sign_out! # hijacked
    else
      @current_connect_user ||= OpenStax::Connect::User.anonymous
      connect_sign_in(OpenStax::Connect::User.where(id: session[:user_id]).first) \
        if @current_connect_user.is_anonymous? && session[:user_id]
    end

    @current_connect_user
  end  
 
  # Sets (signs in) the provided app user.
  def current_user=(user)
    self.current_connect_user = OpenStax::Connect.configuration.user_provider.app_user_to_connect_user(user)
    @current_app_user
  end

  # Quasi "private" method that sets the current connect user, also updates the cache
  # of the current app user.
  def current_connect_user=(user)
    @current_connect_user = user || OpenStax::Connect::User.anonymous
    if @current_connect_user.is_anonymous?
      session[:user_id] = nil
      cookies.delete(:secure_user_id)
    else
      session[:user_id] = @current_connect_user.id
      cookies.signed[:secure_user_id] = {secure: true, value: "secure#{@current_connect_user.id}"}
    end
    @current_app_user = OpenStax::Connect.configuration.user_provider.connect_user_to_app_user(@current_connect_user)
    @current_connect_user
  end

  # Signs in the given app user
  def sign_in(user)
    self.current_user = user
  end

  def connect_sign_in(user)
    self.current_connect_user = user
  end

  # Signs out the user
  def sign_out!
    self.current_connect_user =  OpenStax::Connect::User.anonymous
  end

  # Returns true iff there is a user signed in
  def signed_in?
    !current_connect_user.is_anonymous?
  end

  # Useful in before_filters
  def authenticate_user!
    redirect_to openstax_connect.login_path unless signed_in?
  end

protected

  helper_method :current_user, :current_user=, :signed_in?

end

