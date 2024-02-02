module Api
  class CommentsController < ApiController
    def index
      post = Post.find(params[:post_id])
      render json: ::CommentSerializer.new(post.comments)
    end
  end
end