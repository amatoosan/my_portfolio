class QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "問題を投稿しました。"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

end
