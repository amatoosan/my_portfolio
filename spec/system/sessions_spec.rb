require 'rails_helper'

RSpec.describe 'Sessions', type: :system do

  describe "login with a valid value" do
    let!(:user) { create(:user) }

    before do
      valid_login(user)
    end
    subject { page }

    context "when you log in" do
      it "go to the user page, logout, and only the profile link should be visible" do
        is_expected.to have_current_path user_path(user)
        is_expected.to have_link href: user_path(user)
        is_expected.to have_link href: logout_path
        is_expected.to_not have_link nil, href: login_path
        is_expected.to_not have_link nil, href: signup_path
      end
    end

    context "when you log out" do
      it "go to the top page and only the login and sign-up links should be visible" do
        click_link 'ログアウト'
        is_expected.to have_current_path root_path
        is_expected.to have_link href: login_path
        is_expected.to have_link href: signup_path
        is_expected.to_not have_link nil, href: logout_path
        is_expected.to_not have_link nil, href: user_path(user)
      end
    end
  end

  describe "logging in with an invalid value" do
    before do
      visit login_path
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button 'ログイン'
    end
    subject { page }

    context "when user information is not correct" do
      it "alert messages should be displayed" do
        is_expected.to have_selector('.alert-danger', 
                                      text: 'Invalid email/password combination')
        is_expected.to have_current_path login_path
      end
    end

    context "when you move to another page" do
      it "alert messages should disappear" do
        visit root_path
        is_expected.to_not have_selector('.alert-danger', 
                                          text: 'Invalid email/password combination')
      end
    end
  end
end