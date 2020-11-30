require 'rails_helper'

RSpec.describe "Homes", type: :request do
  it "get top" do
    get '/homes/top'
    expect(response.status).to eq(200)
  end
end
