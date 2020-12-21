require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do

  describe "user_create" do
    context "when the user registration is successful" do
      it "increase in the number of users" do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      it "logging in and being redirected to a user page" do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
          subject { response }
          it { is_expected.to redirect_to user_path(User.last) } #showページにリダイレクトされる
          it { is_expected.to have_http_status 200 } #リダイレクト成功
          expect(is_logged_in?).to be_truthy
        end
      end
    end

    context 'when you add a user image and create an account' do
      let(:user_params) do
        attributes_for(:user, name: 'test',
                              email: 'test@example.com',
                              password: 'password',
                              password_confirmation: 'password',
                              picture: Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/images.png')))
      end
      it 'increase in the number of users' do
        expect do
          post signup_path, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
    end

    context 'when you try to create a user with invalid information' do
      let(:user_params) do
        attributes_for(:user, name: '',
                              email: 'user@invalid',
                              password: '',
                              password_confirmation: '')
      end
      it 'no increase in the number of users' do
        expect do
          post signup_path, params: { user: user_params }
        end.to change(User, :count).by(0)
      end
    end

  end
end
