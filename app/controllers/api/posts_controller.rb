module Api
  class PostsController < ApiController
    def index
      posts = Post.all
      render json: ::PostSerializer.new(posts)
    end

    def create
      post = Post.create(post_params)
      render json: ::PostSerializer.new(post)
    end

    def show
      post = Post.find(params[:id])
      render json: ::PostSerializer.new(post)
    end

    private
      def post_params
        params.require(:post).permit(:title, :body, :tags)
      end
  end
end