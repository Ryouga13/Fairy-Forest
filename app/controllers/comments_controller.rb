class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "コメントを追加しました。" }
        format.js   # `create.js.erb` を実行
      else
        format.html { render 'posts/show' }
        format.js   # エラー時も非同期で処理
      end
    end
  end
  

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "コメントを削除しました。" }
      format.js   # `destroy.js.erb` を実行
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:comment)
  end


end
