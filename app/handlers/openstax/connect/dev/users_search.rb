module OpenStax::Connect::Dev
  class UsersSearch

    include Lev::Handler

    paramify :search do
      attribute :search_type, type: String
      validates :search_type, presence: true,
                              inclusion: { in: %w(Name Username Any),
                                           message: "is not valid" }

      attribute :search_terms, type: String
      validates :search_terms, presence: true                               
    end

  protected

    def authorized?
      !Rails.env.production? || caller.is_administrator?
    end

    def exec
      terms = search_params.search_terms
      type = search_params.search_type

      if terms.blank?
        users = User.where{id == nil}.where{id != nil} # Empty
      else
        # Note: % is the wildcard. This allows the user to search
        # for stuff that "begins with" but not "ends with".
        case type
        when 'Name'
          users = User.scoped
          terms.gsub(/[%,]/, '').split.each do |t|
            next if t.blank?
            query = t + '%'
            users = users.where{(first_name =~ query) | (last_name =~ query)}
          end
        when 'Username'
          query = terms.gsub('%', '') + '%'
          users = where{username =~ query}
        else # Any
          users = User.scoped
          terms.gsub(/[%,]/, '').split.each do |t|
            next if t.blank?
            query = t + '%'
            users = users.where{(first_name =~ query) | 
                        (last_name =~ query) |
                        (username =~ query)}
          end
        end
      end

      results[:users] = users
    end

    def default_transaction_isolation
      :no_transaction
    end

  end
end
