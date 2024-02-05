module Api
  class CommentsController < ApiController
    def index
      post = Post.find(params[:post_id])
      render json: ::CommentSerializer.new(post.comments)
    end

    def create
      post = Post.find(params[:post_id])
      comment = post.comments.create(comment_params)
      render json: ::CommentSerializer.new(comment)
    end

    private
      def comment_params
        params.require(:comment).permit(:message, :votes)
      end
  end
end