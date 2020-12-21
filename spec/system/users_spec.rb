require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "signup" do
    context "when the value you entered is correct" do
      it "a welcome message should be displayed" do
        visit signup_path
        fill_in 'ユーザーID', with: 'testuser'
        fill_in 'メールアドレス', with: 'testuser@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '新規登録'
        expect(page).to have_selector('.alert-success', text: '登録成功しました！QNSへようこそ！')
      end
    end

    context 'when the value you entered is incorrect' do
      before do
        visit signup_path
        fill_in 'ユーザーID', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード確認', with: ''
        click_button '新規登録'
      end
      subject { page }

      it 'error messages should be displayed' do
        is_expected.to have_selector('#error_explanation')
        is_expected.to have_selector('.alert-danger', text: 'The form contains 4 errors.')
        is_expected.to have_content("Name can't be blank")
        is_expected.to have_content("Email can't be blank")
        is_expected.to have_content("Email is invalid")
        is_expected.to have_content("Password can't be blank")
      end
      
      it 'the sign-up page should be drawn' do
        is_expected.to have_current_path '/signup'
      end

    end
  end
end
