module OpenStax::Connect
  class User < ActiveRecord::Base

    validates :username, uniqueness: true
    validates :username, presence: true
    validates :openstax_uid, presence: true

    attr_reader :is_anonymous

    before_save :cannot_save_anonymous

    # first and last names are not required

    def is_anonymous?
      is_anonymous == true
    end

    def name
      (first_name || last_name) ? [first_name, last_name].compact.join(" ") : username
    end

    def casual_name
      first_name || username
    end    

    def self.anonymous_instance
      @@anonymous_instance ||= User.new(
        username: 'anonymous',
        first_name: 'Guest',
        last_name: 'User'
        openstax_uid: nil,
        is_anonymous: true
      )
    end

  protected

    def cannot_save_anonymous
      !is_anonymous?
    end

  end
end