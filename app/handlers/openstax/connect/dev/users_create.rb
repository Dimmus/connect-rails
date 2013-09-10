class OpenStax::Connect::Dev::UsersCreate
  include OpenStax::Utilities::Handler

protected

  def authorized?
    !Rails.env.production?
  end

  def exec
    u = User.create do |user|
      user.first_name = params[:first_name]
      user.last_name = params[:last_name]
      user.username = params[:username]
      user.is_administrator = params[:is_administrator]
      user.openstax_uid = available_openstax_uid
    end
  
    u.errors.each_type do |attribute, type|
      errors.add(code: type, data: u, ui_label: attribute)
    end

    results[:user] = u
  end

  def available_openstax_uid
    (User.order("openstax_uid DESC").first.try(:openstax_uid) || 0) + 1
  end

end 
