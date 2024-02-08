module Api
  class PostsController < ApiController
    before_action :authenticate_user!, only: %i[create update destroy upvote_post downvote_post]
    before_action :set_post, only: %i[show update destroy upvote_post downvote_post]
    
    def index
      posts = Post.where(is_draft: false).order(created_at: :desc)
      render json: ::PostSerializer.new(posts)
    end

    def create
      @post = Post.new(post_params)
      
      if @post.valid?
        @post.save
        render json: ::PostSerializer.new(@post)
      else
        errors = @post.errors.full_messages
        render json: { errors: errors }
      end
    end

    def show
      render json: ::PostSerializer.new(@post)
    end

    def update
      if current_user && current_user.id == @post.user.id
        @post.update(post_params)
        render json: ::PostSerializer.new(@post)
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

    # CUSTOM ROUTES

    def get_trending_posts
      posts = Post.where(is_draft: false).order(votes_count: :desc).limit(10)

      

      render json: ::PostSerializer.new(posts)
    end

    def upvote_post
      toggle_vote('upvotes')
      remove_vote('downvotes')

      @post.save
      render json: ::PostSerializer.new(@post)
    end

    def downvote_post
      toggle_vote('downvotes')
      remove_vote('upvotes')

      @post.save
      render json: ::PostSerializer.new(@post)
    end

    private
      def post_params
        params.require(:post).permit(
          :title, 
          :body, 
          :is_draft,
          :votes => [:upvotes => [], :downvotes => []],
          tags: []
        ).merge(user: current_user)
      end

      def set_post
        @post = Post.find(params[:id])
      end

      def toggle_vote(vote_type)
        if @post.votes[vote_type].include?(current_user.id)
          @post.votes[vote_type].delete(current_user.id)
        else
          @post.votes[vote_type] << current_user.id
        end
      end

      def remove_vote(vote_type)
        if @post.votes[vote_type].include?(current_user.id)
          @post.votes[vote_type].delete(current_user.id)
        end
      end
  end
end