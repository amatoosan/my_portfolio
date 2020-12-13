require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  before do
    @user = build(:user)
    remember(@user)
  end

  describe 'current_user' do
    context 'logging in' do
      it 'current user and logged in user are equal' do
        expect(@user).to eq current_user
        expect(is_logged_in?).to be_truthy
      end
    end
    context 'update Remember Digest with new tokens' do
      it 'current user becomes nil' do
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
        expect(current_user).to eq nil
      end
    end
  end
end
