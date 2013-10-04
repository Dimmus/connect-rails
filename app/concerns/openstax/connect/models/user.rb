module OpenStax::Connect::Models::User
  extend ActiveSupport::Concern

  included do
    validates :username, uniqueness: true
    validates :username, presence: true
    validates :openstax_uid, presence: true

    # first and last names are not required

    def is_administrator?
      self.is_administrator
    end

    def is_anonymous?
      false
    end

    def name
      (first_name || last_name) ? [first_name, last_name].compact.join(" ") : username
    end

    def casual_name
      first_name || username
    end    
  end  

end

