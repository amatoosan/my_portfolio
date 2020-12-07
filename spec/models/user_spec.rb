require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = build(:user)
  end

  it "値が入っている場合" do
    expect(@user).to be_valid
  end

  it "emailが空白の場合" do
    #FactoryBotに登録したユーザー情報のemailを空白に変更
    @user.email = " "
    expect(@user).to be_invalid
  end

  it "nameの文字数" do
    @user.name = "a" * 51
    expect(@user).to be_invalid
  end

  it "emailの文字数" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).to be_invalid
  end

end
