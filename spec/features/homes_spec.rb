require 'rails_helper'

RSpec.feature "Homes", type: :feature do

  scenario "homeへページ遷移できるか" do
    visit root_path
    click_link "サインイン"

    expect(page).to have_content("サインインです")
  end

end
