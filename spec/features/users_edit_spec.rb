require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  let(:user) { create(:user) }

  before do
    valid_login(user)
    visit user_path(user)
    click_link "編集"
  end

  context "input is correct" do
    it "successful edit" do
      fill_in "ユーザーID", with: "update"
      fill_in "メールアドレス", with:  "update@example.com"
      click_button "更新"

      expect(current_path).to eq user_path(user)
      expect(user.reload.name).to eq "update"
      expect(user.reload.email).to eq "update@example.com"
    end
  end

  context "incorrectly entered information" do
    scenario "unsuccessful edit" do
      fill_in "ユーザーID", with: ""
      fill_in "メールアドレス", with: "foo@invalid"
      click_button "更新"

      expect(user.reload.name).to_not eq ""
      expect(user.reload.email).to_not eq "foo@invalid"
    end
  end

end