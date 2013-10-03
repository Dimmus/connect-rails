module OpenStax::Connect::Models::AnonymousUser
  extend ActiveSupport::Concern

  included do
    include Singleton

    def is_administrator?
      false
    end

    def is_anonymous?
      true
    end

    def id
      nil
    end

    # Necessary if an anonymous user ever runs into an Exception
    # or else the developer email doesn't work
    def username
      'anonymous'
    end

    def first_name
      'Guest User'
    end

    def last_name
      'Guest User'
    end

    def name
      'Guest User'
    end

    def openstax_uid
      nil
    end
  end  

end

