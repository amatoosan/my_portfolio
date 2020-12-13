require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe 'POST #create' do
    #有効なユーザーの検証
    context 'valid request' do
      #ユーザーが追加される
      it 'adds a user' do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
      #ユーザーが追加されたときの検証
      context 'adds a user' do
        before { post signup_path, params: { user: attributes_for(:user) } }
        subject { response }
        it { is_expected.to redirect_to user_path(User.last) } #showページにリダイレクトされる
        it { is_expected.to have_http_status 302 } #リダイレクト成功
        it 'log in' do
          expect(is_logged_in?).to be_truthy
        end
      end
    end

    #無効なリクエスト
    context 'invalid request' do
      #無効なユーザーを作成
      let(:user_params) do
        attributes_for(:user, name: '',
                              email: 'user@invalid',
                              password: '',
                              password_confirmation: '')
      end
      #無効なユーザーが追加されないことを確認
      it 'does not add a user' do
        expect do
          post signup_path, params: { user: user_params }
        end.to change(User, :count).by(0)
      end
    end

    context 'images' do
      let(:user_params) do
        attributes_for(:user, name: 'test',
                              email: 'test@example.com',
                              password: 'password',
                              password_confirmation: 'password',
                              image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/images.png')))
      end
      it 'user images' do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
    end
  end
end
