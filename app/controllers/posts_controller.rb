class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    if params[:word].present?
      # 検索ワードが存在する場合は検索
      @posts = Post.where("title LIKE ? OR content LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%")
    else
      @posts = Post.all
    end
  end

  def search
    @word = params[:word]
    @posts = Post.where("title LIKE ? OR body LIKE ?", "%#{@word}%", "%#{@word}%")
    render :index
  end

  def search_tag
    @tag_list=Tag.all
    @tag=Tag.find(params[:tag_id])
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list=@post.tags.pluck(:name).join(',')
    unless @post.user.id == current_user.id
      redirect_to posts_path
    end
  end

  
  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_tag(tag_list)
      flash[:notice] = "編集に成功しました。"
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :body, :category, :star)
  end

end
