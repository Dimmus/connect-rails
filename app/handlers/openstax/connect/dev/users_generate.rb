module OpenStax::Connect::Dev
  class UsersGenerate
    include Lev::Handler

  protected

    paramify :generate do
      attribute :count, type: Integer
      validates :count, allow_nil: false,
                        numericality: { greater_than: -1 }
    end

    def setup
    end

    def authorized?
      !Rails.env.production?
    end

    def exec
      generate_params.count.times do 
        while !(User.where(:username => (username = SecureRandom.hex(4))).empty?) do; end

        u = User.create do |user|
          user.first_name = "Jane#{username}"
          user.last_name = "Doe#{username}"
          user.username = username
          user.is_administrator = false
          user.openstax_uid = available_openstax_uid
        end
      end
    end

    def available_openstax_uid
      (User.order("openstax_uid DESC").first.try(:openstax_uid) || 0) + 1
    end

  end 
end