module Api
  class UsersController < ApiController

    def get_user_posts
      begin
        user = User.find(params[:id])
        render json: { posts: user.posts }
      rescue ActiveRecord::RecordNotFound
        render json: {
          status: {
            code: 404,
            message: 'User does not exist.'
          }
        }, status: :not_found
      end
    end

  end
end