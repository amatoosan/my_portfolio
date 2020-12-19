require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  let(:user) { create(:user) }

  # ユーザー編集成功
  scenario "successful edit" do
    valid_login(user)
    visit user_path(user)
    click_link "編集"

    fill_in "ユーザーID", with: "update"
    fill_in "メールアドレス", with:  "update@example.com"
    click_button "更新"

    expect(current_path).to eq user_path(user)
    expect(user.reload.name).to eq "update"
    expect(user.reload.email).to eq "update@example.com"
  end

  # ユーザー編集失敗
  scenario "unsuccessful edit" do
    valid_login(user)
    visit user_path(user)
    click_link "編集"

    fill_in "ユーザーID", with: ""
    fill_in "メールアドレス", with: "foo@invalid"
    click_button "更新"

    expect(user.reload.name).to_not eq ""
    expect(user.reload.email).to_not eq "foo@invalid"
  end

end