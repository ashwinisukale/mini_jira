require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #data" do
    xit "returns http success" do
      get :data
      expect(response).to have_http_status(:success)
    end
  end

end
