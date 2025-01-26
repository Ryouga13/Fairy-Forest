class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to admin_post_path(@post.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to admin_posts_path
  end

  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to admin_post_path(@post.id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  
  def set_post
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :category)
  end


end
