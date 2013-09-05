

class OpenStax::Connect::ProcessOmniauthAuthentication

  def self.exec(auth_data, current_user)
    raise OpenStax::Connect::SecurityTransgression if auth_data.provider != "openstax"

    return current_user if 
      !current_user.nil? && 
      current_user.openstax_uid == auth_data.uid

    existing_user = User.where(openstax_uid: auth_data.uid).first
    return existing_user if !existing_user.nil?

    return User.create do |user|
      user.openstax_uid = auth_data.uid
    end
  end

end