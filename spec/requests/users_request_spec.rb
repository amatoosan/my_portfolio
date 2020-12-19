require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:testuser) { create(:testuser) }

  describe "GET /new" do
    it "returns http success" do
      get "/signup"
      expect(response).to have_http_status(:success)
    end
  end

  describe "#edit" do
    # 認可されたユーザーとして
    context "as an authorized user" do
      it "responds successfully" do
        log_in_as(user)
        get edit_user_path(user)
        expect(response.body).to include "編集ページです"
        expect(response).to have_http_status "200"
      end
    end

    # ログインしていないユーザーの場合
    context "as a guest" do 
      # ログイン画面にリダイレクトすること
      it "redirects to the login page" do
        get edit_user_path(user)
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    # 異なるアカウントの編集ページへのアクセスが失敗すること
    context "as other user" do 
      it "redirects to the login page" do
        log_in_as(testuser)
        get edit_user_path(user)
        expect(response).to have_http_status "302"
      end
    end

  end

  describe "#update" do
    # 認可されたユーザーとして
    context "as an authorized user" do
      # ユーザーを更新できること
      it "updates a user" do
        user_params = attributes_for(:user, name: "NewName")
        log_in_as(user)
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq "NewName"
      end
    end

    # ログインしていないユーザーの場合
    context "as a guest" do 
      # ログイン画面にリダイレクトすること
      it "redirects to the login page" do
        user_params = attributes_for(:user, name: "NewName")
        patch user_path(user), params: { id: user.id, user: user_params }
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end

    # アカウントが違うユーザーの場合
    context "as other user" do 
      # ユーザーを更新できないこと
      it "does not update the user" do
        user_params = attributes_for(:user, name: "NewName")
        log_in_as(testuser)
        patch user_path(user), params: { user: user_params }
        expect(user.reload.name).to_not eq "NewName"
      end
    end

  end

end
