class UsersController < ApplicationController
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


  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
