class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]


  def mypage
    @user = current_user
    @posts = @user.posts
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to mypage_users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "編集に成功しました。"
      redirect_to mypage_users_path
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def check
    @user = current_user
  end

  def withdrawal
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to new_user_registration_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@dmm.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

end
