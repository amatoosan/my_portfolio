require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  let(:user) { create(:user) }

  # ユーザー編集成功
  scenario "successful edit" do
    valid_login(user)
    visit user_path(user)
    click_link "編集"

    fill_in "ユーザーID", with: user.name
    fill_in "メールアドレス", with: user.email
    #fill_in "パスワード", with: user.password, match: :first
    #fill_in "パスワード確認", with: "testjobs"
    click_button "更新"

    expect(current_path).to eq user_path(user)
    expect(user.reload.email).to eq "test@example.com"
  end

  # ユーザー編集失敗
  scenario "unsuccessful edit" do
    valid_login(user)
    visit user_path(user)
    click_link "編集"

    fill_in "ユーザーID", with: "foo@invalid"
    fill_in "メールアドレス", with: "foo@invalid"
    fill_in "パスワード", with: "foo", match: :first
    fill_in "パスワード確認", with: "bar"
    click_button "更新"

    expect(user.reload.email).to_not eq "foo@invalid"
  end

end