class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @posts = Post.where(user: current_user)
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
            render :new
        end
    end

    private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
