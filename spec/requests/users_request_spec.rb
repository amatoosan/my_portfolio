require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:testuser) { create(:testuser) }

  describe "signup" do
    context "when you access the sign-up page" do
      it "successful access" do
        get "/signup"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "edit" do
    context "when accessed by the correct user" do
      it "the HTTP response should return 200" do
        log_in_as(user)
        get edit_user_path(user)
        expect(response.body).to include "編集ページです"
        expect(response).to have_http_status "200"
      end
    end

    context "when accessed by an unlogged user" do 
      it "being redirected to the login page" do
        get edit_user_path(user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "when you access a different user's page" do 
      it "being redirected to the login page" do
        log_in_as(testuser)
        get edit_user_path(user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "update" do
    context "when the logged-in user's information is updated" do
      it "ability to update user information" do
        user_params = attributes_for(:user, name: "NewName")
        log_in_as(user)
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq "NewName"
      end
    end

    context "when you try to update your user information without logging in" do 
      it "being redirected to the login page" do
        user_params = attributes_for(:user, name: "NewName")
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    context "when you try to update the information of a different user" do 
      it "inability to update user information" do
        user_params = attributes_for(:user, name: "NewName")
        log_in_as(testuser)
        patch user_path(user), params: { user: user_params }
        expect(user.reload.name).to_not eq "NewName"
      end
    end

  end

end
