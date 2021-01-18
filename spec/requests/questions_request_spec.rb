require 'rails_helper'

RSpec.describe "Questions", type: :request do

  describe "Questions#create" do
    let(:question) { attributes_for(:question) }
    let(:post_request) { post questions_path, params: { question: question } }

    context "when not logged in" do
      it "the number of problem posts should remain the same" do
        expect { post_request }.to change(Question, :count).by(0)
      end

      it "redirecting to the login page" do
        expect(post_request).to redirect_to login_url
      end
    end
  end

  describe "Questions#destroy" do
    let!(:question) { create(:question) }
    let(:delete_request) { delete question_path(question) }

    context "when not logged in" do
      it "the number of problem posts should remain the same" do
        expect { delete_request }.to change(Question, :count).by(0)
      end

      it "redirecting to the login page" do
        expect(delete_request).to redirect_to login_url
      end
    end
  end

end
