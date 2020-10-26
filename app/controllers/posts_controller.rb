class PostsController < ApplicationController
  def index
    @posts = Post.all
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "投稿に成功しました！"
    else
      render 'posts/index'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :rating, :description)
  end
end
