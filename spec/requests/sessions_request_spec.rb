require 'rails_helper'

RSpec.describe 'access to sessions', type: :request do
  let!(:user) { create(:user) }

  describe "log in" do
    context "when you log in with the correct information" do
      it "redirect to the user page and that the user ID is stored in the session" do
        post login_path, params: { session: { email: user.email,
                                              password: user.password } }
        expect(response).to redirect_to user_path(user)
        expect(is_logged_in?).to be_truthy
      end
    end
  end

  describe "log out" do
    context "when you log out" do
      it "redirecting to the top page and removing the user ID from the session" do
        delete logout_path
        expect(response).to redirect_to root_path
        delete logout_path #ログアウトがログイン中のみ行われることの確認
        expect(is_logged_in?).to be_falsey
      end
    end
  end

  describe "remember me" do
    context "when you log in with Remember Me enabled" do
      it "the presence of a remembrance token in the cookie" do
        post login_path, params: { session: { email: user.email,
                                              password: user.password,
                                              remember_me: '1'} }
        expect(response.cookies['remember_token']).to_not eq nil
      end
    end

    context "when you log in without activating Remember Me" do
      it "no remembrance token in the cookie" do
        post login_path, params: { session: { email: user.email,
                                              password: user.password,
                                              remember_me: '0'} }
        expect(response.cookies['remember_token']).to eq nil
      end
    end
  end

end
