module Api
  class PostsController < ApiController
    before_action :authenticate_user!, only: %i[create destroy]
    before_action :set_post, only: %i[show update destroy]
    
    def index
      posts = Post.all
      render json: ::PostSerializer.new(posts)
    end

    def create
      post = Post.create(post_params)
      render json: ::PostSerializer.new(post)
    end

    def show
      render json: ::PostSerializer.new(@post)
    end

    def update
      if current_user && current_user.id == @post.user.id
        @post.update(post_params)
        render json: { message: 'Post was updated successfully.' }
      else
        render json: { status: 401, message: 'Unauthorized' }
      end
    end

    def destroy      
      if current_user && current_user.id == @post.user.id
        @post.destroy
        render json: { message: 'Post was deleted successfully.' }
      else
        render json: { status: 401, message: 'Unauthorized' }
      end
    end

    private
      def post_params
        params.require(:post).permit(:title, :body, :votes, :tags).merge(user: current_user)
      end

      def set_post
        @post = Post.find(params[:id])
      end
  end
end