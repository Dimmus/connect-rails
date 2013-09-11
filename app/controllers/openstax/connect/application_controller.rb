# References:
#  http://edgeguides.rubyonrails.org/engines.html#using-a-class-provided-by-the-application

# Inherit from the applications ApplicationController to share some methods
class OpenStax::Connect::ApplicationController < ApplicationController

  include Lev::HandleWith

end
