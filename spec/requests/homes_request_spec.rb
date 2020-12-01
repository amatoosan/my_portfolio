require 'rails_helper'

RSpec.describe "Homes", type: :request do

  it "get root" do
    get '/'
    expect(response.status).to eq(200)
    expect(response.body).to include "Topページです"
    get "/signup"
    expect(response).to have_http_status(:success)
  end



end
