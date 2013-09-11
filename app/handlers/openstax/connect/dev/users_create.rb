class OpenStax::Connect::Dev::UsersCreate
  include Lev::Handler

protected

  def setup
  end

  def authorized?
    !Rails.env.production?
  end

  def exec
    u = User.create do |user|
      user.first_name = params[:register][:first_name]
      user.last_name = params[:register][:last_name]
      user.username = params[:register][:username]
      user.is_administrator = params[:register][:is_administrator]
      user.openstax_uid = available_openstax_uid
    end
  
    transfer_errors_from(u, :register)

    results[:user] = u
  end

  def available_openstax_uid
    (User.order("openstax_uid DESC").first.try(:openstax_uid) || 0) + 1
  end

end 
