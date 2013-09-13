module OpenStax::Connect::Dev
  class UsersGenerate
    include Lev::Handler

  protected

    paramify :generate do
      attribute :count, type: Integer
    end

    def setup
    end
 

    def authorized?
      !Rails.env.production?
    end

    def exec
      # if params[:generate][:count] < 0 freak out
    # problem here is that count is a string!
      count = params[:generate][:count]
debugger
      count = generate_params.count

      puts 'hi'

      # count.times.do 
      #   # random = SecureRandom.hex(4)

      #   # while !(User.where(:username => (username = SecureRandom.hex(4))).empty?) do 
      #   #   puts 'hi' 
      #   # end

      #   # u = User.create do |user|
      #   #   user.first_name = "Jane#{username}"
      #   #   user.last_name = "Doe#{username}"
      #   #   user.username = username
      #   #   user.is_administrator = false
      #   #   user.openstax_uid = available_openstax_uid
      #   # end
    
      #   # transfer_errors_from(u, :generate)
      #   # return if errors.any?
      # end

    end

    def available_openstax_uid
      (User.order("openstax_uid DESC").first.try(:openstax_uid) || 0) + 1
    end


  end 
end