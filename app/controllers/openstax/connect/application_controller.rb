# References:
#  http://edgeguides.rubyonrails.org/engines.html#using-a-class-provided-by-the-application

module OpenStax
  module Connect

    # Inherit from the applications ApplicationController to share some methods
    class ApplicationController < ActionController::Base
      include Lev::HandleWith
    end

  end
end
