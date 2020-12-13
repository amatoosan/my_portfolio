require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = build(:user)
  end

  context "user test" do
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
  end

  context "email test" do
    it "emailの文字数" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user).to be_invalid
    end

    it "emailのvalidateが正しく機能しているか" do
      addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        expect(build(:user, email: invalid_address)).to be_invalid
      end
    end

    it "一意性が正しく機能しているか" do
      #@userを複製してduplicate_userに格納
      duplicate_user = @user.dup
      #@userのemailを大文字でduplicate_userのemailに格納
      duplicate_user.email = @user.email.upcase
      @user.save!
      expect(duplicate_user).to be_invalid
    end

    it "emailを小文字に変換後の値と大文字を混ぜて登録されたアドレスが同じか" do
      @user.email = "Foo@ExAMPle.CoM"
      @user.save!
      expect(@user.reload.email).to eq "foo@example.com"
    end
  end

  context "password test" do
    it "passwordが空白になっていないか" do
      #"a"が6文字のパスワードのテスト
      @user.password = @user.password_confirmation = "a" * 6
      expect(@user).to be_valid

      #" "が６文字のパスワードのテスト
      @user.password = @user.password_confirmation = " " * 6
      expect(@user).to_not be_valid
    end

    it "パスワードが６桁の時" do
      @user = build(:user, password: "a" * 6, password_confirmation: "a" * 6)
      expect(@user).to be_valid
    end

    it "パスワードが５桁の時" do
      @user = build(:user, password: "a" * 5, password_confirmation: "a" * 5)
      expect(@user).to be_invalid
    end
  end

  it "authenticated?がremember_digestがnilのユーザにはfalseを返す" do
    expect(@user.authenticated?('')).to be_falsey
  end

end
