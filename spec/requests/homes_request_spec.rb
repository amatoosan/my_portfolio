require 'rails_helper'

RSpec.describe "Homes", type: :request do

  context "GET root_path" do
    it "to access the top page" do
      get '/'
      expect(response.status).to eq(200)
      expect(response.body).to include "Topページです"
    end
  end



end
