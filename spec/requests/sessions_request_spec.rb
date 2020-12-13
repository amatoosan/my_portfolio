require 'rails_helper'

RSpec.describe 'access to sessions', type: :request do
  let!(:user) { create(:user) }
  describe 'POST #create' do
    it 'log in and redirect to detail page' do
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      expect(response).to redirect_to user_path(user)
      expect(is_logged_in?).to be_truthy #ログインしているかのテスト、ここでis_logged_in?を使用
    end
  end

  describe 'DELETE #destroy' do
    it 'log out and redirect to root page' do
      delete logout_path
      expect(response).to redirect_to root_path
      delete logout_path #ログアウトがログイン中のみ行われることの確認
      expect(is_logged_in?).to be_falsey #ここでセッションの値をテストしています。
    end
  end

  describe 'remember me' do
    context 'login with remembering' do
      it 'remembers cookies' do
        post login_path, params: { session: { email: user.email,
                                              password: user.password,
                                              remember_me: '1'} }
        expect(response.cookies['remember_token']).to_not eq nil
      end
    end
    context "login without remembering" do
      it "doesn't remember cookies"do
        # クッキーを保存してログイン
        post login_path, params: { session: { email: user.email,
                                              password: user.password,
                                              remember_me: '1'} }
        delete logout_path
        # クッキーを保存せずにログイン
        post login_path, params: { session: { email: user.email,
                                        password: user.password,
                                        remember_me: '0'} }
        expect(response.cookies['remember_token']).to eq nil
      end
    end
  end

end
