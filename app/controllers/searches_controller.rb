class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:word])
      redirect_to search_users_path(word: @word, range: @range)
    else
      @posts = Post.looks(params[:word])
      redirect_to search_posts_path(word: @word, range: @range)
    end
  end


end