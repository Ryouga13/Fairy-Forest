class UsersController < ApplicationController
  before_action :authenticate_user!


  def mypage
    @user = current_user
  end

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
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

end
