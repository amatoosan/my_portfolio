require 'rails_helper'

RSpec.describe Question, type: :model do

  let(:question) { create(:question) }

  it "pass validation" do
    expect(question).to be_valid
  end

  context "when the user-id is nil" do
    it "not passing validation" do
      question.user_id = nil
      expect(question).to be_invalid
    end
  end

  describe "title" do
    context "when the title is less than 25 characters" do
      it "pass validation" do
        question.title = "a" * 25
        expect(question).to be_valid
      end
    end

    context "when the title is more than 26 characters" do
      it "not passing validation" do
        question.title = "a" * 26
        expect(question).to be_invalid
      end
    end
  end

  describe "content" do
    context "when the content is less than 255 characters" do
      it "pass validation" do
        question.content = "a" * 255
        expect(question).to be_valid
      end
    end

    context "when the content is more than 256 characters" do
      it "not passing validation" do
        question.content = "a" * 256
        expect(question).to be_invalid
      end
    end
  end

end
