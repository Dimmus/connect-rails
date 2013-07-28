require 'spec_helper'

module OpenStax::Connect
  describe SessionsController do
  
    describe "GET 'create'" do
      it "returns http success" do
        get 'create'
        response.should be_success
      end
    end
  
  end
end
