class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  #サインアップ時の「Can't verify CSRF token authenticity.」解決用
  skip_before_action :verify_authenticity_token

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "登録成功しました！QNSへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

    private

      def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation,
                                     :profile, :picture)
      end

      # beforeアクション
      #logged_in_userはapplication_controller.rbへ移動

      # 正しいユーザーかどうか確認
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end

end
