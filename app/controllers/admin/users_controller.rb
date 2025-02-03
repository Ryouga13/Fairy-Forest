class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user
  
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

# 論理削除
  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_user_path
  end

  # 論理削除(復活)
  def reactivate
    if @user && @user.is_deleted
      @user.update(is_deleted: false)
      redirect_to admin_user_path, notice: "#{@user.name}さんをアクティブに戻しました。"
    elsif @user
      redirect_to admin_users_path, alert: "#{@user.name}さんは既にアクティブな状態です。"
    else
      redirect_to admin_users_path, alert: "ユーザーが見つかりませんでした。"
    end
  end

# 物理削除
  def destroy
    if @user.is_deleted
      @user.destroy
      redirect_to admin_users_path, notice: "#{@user.name}さんのデータを完全に削除しました。"
    else
      redirect_to admin_users_path, alert: "#{@user.name}さんは退会済みではないため、削除できません。"
    end
  end


  private
  def set_user
    @user = User.find_by(id: params[:id]) # 該当するユーザーを探す。見つからなければnil
  end


end
