require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  before do
    @user = build(:user)
    remember(@user)
  end

  describe "current_user" do
    context "current user and logged in user are equal" do
      it "must be logged in" do
        expect(@user).to eq current_user
        expect(is_logged_in?).to be_truthy
      end
    end

    context "when the Remember token is updated" do
      it "current user must be nil" do
        @user.update_attribute(:remember_digest, User.digest(User.new_token))
        expect(current_user).to eq nil
      end
    end
  end
end
