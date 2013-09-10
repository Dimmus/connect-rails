module OpenStax
  module Connect
    module Dev
      
      class UsersSearch

        include OpenStax::Utilities::Handler

      protected

        def authorized?
          !Rails.env.production? || caller.is_administrator?
        end

        def exec
          type = params[:search_type]
          text = params[:search_terms]

          if text.blank?
            u = User.where{id == nil}.where{id != nil} # Empty
          else
            # Note: % is the wildcard. This allows the user to search
            # for stuff that "begins with" but not "ends with".
            case type
            when 'Name'
              u = User.scoped
              text.gsub(/[%,]/, '').split.each do |t|
                next if t.blank?
                query = t + '%'
                u = u.where{(first_name =~ query) | (last_name =~ query)}
              end
            when 'Email'
              query = text.gsub('%', '') + '%'
              u = where{email =~ query}
            else # All
              u = User.scoped
              text.gsub(/[%,]/, '').split.each do |t|
                next if t.blank?
                query = t + '%'
                u = u.where{(first_name =~ query) | 
                            (last_name =~ query) |
                            (email =~ query)}
              end
            end
          end

          results[:users] = u
        end

      end

    end
  end
end