module OpenStax::Connect

  class SessionsOmniauthAuthenticated
    include Lev::Handler

  protected

    def setup
      @auth_data = request.env['omniauth.auth']
    end

    def authorized?
      @auth_data.provider == "openstax"
    end

    def exec
      results[:user_to_sign_in] = user_to_sign_in
    end

    def user_to_sign_in
      return caller if 
        !caller.nil? && 
        !caller.is_anonymous? &&
        caller.openstax_uid == @auth_data.uid

      existing_user = User.where(openstax_uid: @auth_data.uid).first
      return existing_user if !existing_user.nil?

      return User.create do |user|
        user.openstax_uid = @auth_data.uid
      end
    end
  end

end