require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = build(:user)
  end

  describe "name" do
    context "when the number of characters is 50 or less" do
      it "pass validation" do
        expect(@user.name).to eq "tester"
        expect(@user).to be_valid
        @user.name = "a" * 50
        expect(@user).to be_valid
      end
    end

    context "when the number of characters is 51 or more" do
      it "not passing validation" do
        @user.name = "a" * 51
        expect(@user).to be_invalid
      end
    end
  end

  describe "email" do
    context "when the number of characters is 255 or less" do
      it "pass validation" do
        expect(@user.email).to eq "test@example.com"
        expect(@user).to be_valid
        @user.email = "a" * 243 + "@example.com"
        expect(@user).to be_valid
      end
    end

    context "when the number of characters is 256 or more" do
      it "not passing validation" do
        @user.email = "a" * 244 + "@example.com"
        expect(@user).to be_invalid
      end
    end

    context "when it was blank" do
      it "not passing validation" do
        @user.email = " "
        expect(@user).to be_invalid
      end
    end

    context "when not a regular expression" do
      it "not passing validation" do
        addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          expect(build(:user, email: invalid_address)).to be_invalid
        end
      end
    end

    context "when you try to register an existing email address" do
      it "not passing validation" do
        #@userを複製してduplicate_userに格納
        duplicate_user = @user.dup
        #@userのemailを大文字でduplicate_userのemailに格納
        duplicate_user.email = @user.email.upcase
        @user.save!
        expect(duplicate_user).to be_invalid
      end
    end

    context "when you register an email address that contains capital letters" do
      it "must be converted to lower case" do
        @user.email = "Foo@ExAMPle.CoM"
        @user.save!
        expect(@user.reload.email).to eq "foo@example.com"
      end
    end
  end

  describe "password" do
    context "when the number of characters is 6 or more" do
      it "pass validation" do
        @user.password = @user.password_confirmation = "a" * 6
        expect(@user).to be_valid
      end
    end

    context "when the number of characters is less than 5" do
      it "not passing validation" do
        @user.password = @user.password_confirmation = "a" * 5
        expect(@user).to be_invalid
      end
    end

    context "when the number of characters is 6 or more, but they are all blank" do
      it "not passing validation" do
        @user.password = @user.password_confirmation = " " * 6
        expect(@user).to be_invalid
      end
    end
  end

  describe "profile" do
    context "when the number of characters is 255 or less" do
      it "pass validation" do
        @user.profile = "a" * 255
        expect(@user).to be_valid
      end
    end

    context "when the number of characters is 256 or more" do
      it "not passing validation" do
        @user.profile = "a" * 256
        expect(@user).to be_invalid
      end
    end
  end

  context "when no entry is made" do
    it "pass validation" do
      @user.profile = ""
      expect(@user).to be_valid
    end
  end

  describe "authenticated?" do
    context "when remember_token is blank" do
      it "return false" do
        expect(@user.authenticated?('')).to be_falsey
      end
    end
  end

end
