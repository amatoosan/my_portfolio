require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'user create a new account' do
    #有効な値が入力されたとき
    context 'enter an valid values' do
      before do
        visit signup_path
        fill_in 'ユーザーID', with: 'testuser'
        fill_in 'メールアドレス', with: 'testuser@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '新規登録'
      end
      #フラッシュメッセージが出る
      it 'gets an flash message' do
        expect(page).to have_selector('.alert-success', text: '登録成功しました！QNSへようこそ！')
      end
    end

    #無効な値が入力されたとき
    context 'enter an invalid values' do
      before do
        visit signup_path
        fill_in 'ユーザーID', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード確認', with: ''
        click_button '新規登録'
      end
      subject { page }
      #エラーの検証
      it 'gets an errors' do
        is_expected.to have_selector('#error_explanation')
        is_expected.to have_selector('.alert-danger', text: 'The form contains 6 errors.')
        is_expected.to have_content("Password can't be blank", count: 2)
      end
      #今いるページのURLの検証
      it 'render to /signup url' do
        is_expected.to have_current_path '/signup'
      end
    end

  end
end
