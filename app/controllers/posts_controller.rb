class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @posts = Post.all
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
            respond_to do |format|
              format.html { redirect_to posts_path }
              format.turbo_stream
            end
        else
          respond_to do |format|
            format.html { redirect_to posts_path }
            format.turbo_stream
          end
        end
    end

    private

  def post_params
    params.require(:post).permit(:content, :image, :visibility)
  end
end
