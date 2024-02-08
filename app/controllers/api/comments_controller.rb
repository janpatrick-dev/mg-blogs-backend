module Api
  class CommentsController < ApiController
    before_action :set_post, except: %i[destroy]
    before_action :set_comment, only: %i[update destroy upvote_comment downvote_comment]
    before_action :authenticate_user!, only: %i[create update destroy upvote_comment downvote_comment]

    def index
      render json: ::CommentSerializer.new(@post.comments)
    end

    def create
      @comment = @post.comments.new(comment_params)

      if @comment.valid?
        @comment.save
        render json: ::CommentSerializer.new(@comment)
      else
        errors = @comment.errors.full_messages
        render json: { errors: errors }
      end
    end

    def update
      comment = Comment.find(params[:id])

      if current_user && current_user.id == @comment.user.id
        @comment.update(comment_params)
        render json: ::CommentSerializer.new(@comment)
      else
        render json: { status: 401, message: 'Unauthorized' }
      end
    end

    def destroy
      if current_user && current_user.id == @comment.user.id
        @comment.destroy
        render json: { message: 'Comment was deleted successfully.' }
      else
        render json: { status: 401, message: 'Unauthorized' }
      end
    end

    # CUSTOM ROUTES

    def upvote_comment
      toggle_vote('upvotes')
      remove_vote('downvotes')

      @comment.save
      render json: ::CommentSerializer.new(@comment)
    end

    def downvote_comment
      toggle_vote('downvotes')
      remove_vote('upvotes')

      @comment.save
      render json: ::CommentSerializer.new(@comment)
    end

    private
      def comment_params
        params.require(:comment).permit(
          :message, 
          :votes => [:upvotes => [], :downvotes => []],
        ).merge(user: current_user)
      end

      def set_post
        @post = Post.find(params[:post_id])
      end

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def toggle_vote(vote_type)
        if @comment.votes[vote_type].include?(current_user.id)
          @comment.votes[vote_type].delete(current_user.id)
        else
          @comment.votes[vote_type] << current_user.id
        end
      end

      def remove_vote(vote_type)
        if @comment.votes[vote_type].include?(current_user.id)
          @comment.votes[vote_type].delete(current_user.id)
        end
      end
  end
end