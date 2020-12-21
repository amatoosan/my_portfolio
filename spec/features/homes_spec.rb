require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  let(:user) { create(:user) }

  describe "go to each page from Home" do
    context "not logged in" do
      it "must be able to transition to sign-in" do
        visit root_path
        click_link "サインイン"
        expect(page).to have_content("サインイン")
      end

      it "must be able to transition to login" do
        visit root_path
        click_link "ログイン"
        expect(page).to have_content("ユーザー登録がお済みでない方はこちらへ")
      end
    end

    context "logged in" do
      before do
        valid_login(user)
        visit user_path(user)
      end

      it "must be able to transition to edit" do
        visit root_path
        click_link "編集"
        expect(page).to have_content("編集ページです")
      end

      it "must be able to transition to profile" do
        visit root_path
        click_link "プロフィール"
        expect(page).to have_content("プロフィール")
      end

      it "logout" do
        visit root_path
        click_link "ログアウト"
        expect(current_path).to eq root_path
      end
    end
    
  end

end
