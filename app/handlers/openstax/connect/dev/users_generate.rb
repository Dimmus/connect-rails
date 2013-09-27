module OpenStax::Connect::Dev
  class UsersGenerate
    include Lev::Handler

  protected

    paramify :generate do
      attribute :count, type: Integer
      validates :count, numericality: { only_integer: true,
                                        greater_than_or_equal_to: 0 }
    end

    def authorized?
      !Rails.env.production?
    end

    def handle
      generate_params.count.times do 
        while !(User.where(:username => (username = SecureRandom.hex(4))).empty?) do; end

        u = User.create do |user|
          user.first_name = "Jane#{username}"
          user.last_name = "Doe#{username}"
          user.username = username
          user.is_administrator = false
          user.openstax_uid = available_openstax_uid
        end

        result.add_output(:users, u)
      end
    end

    def available_openstax_uid
      (User.order("openstax_uid DESC").first.try(:openstax_uid) || 0) + 1
    end

  end 
end