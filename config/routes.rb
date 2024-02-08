Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    ### GET ENDPOINTS ###
    get '/users/:id', to: 'users#get_user_by_id'
    get '/users/:id/posts', to: 'users#get_user_posts'

    get '/posts/trending', to: 'posts#get_trending_posts'

    ### POST ENDPOINTS ###
    post '/posts/:post_id/comments/:id', to: 'comments#add_reply_to_comment'

    ### PUT ENDPOINTS ###
    put '/posts/:id/upvote', to: 'posts#upvote_post'
    put '/posts/:id/downvote', to: 'posts#downvote_post'

    put '/posts/:post_id/comments/:id/upvote', to: 'comments#upvote_comment'
    put '/posts/:post_id/comments/:id/downvote', to: 'comments#downvote_comment'


    resources :posts, only: %i[index show create update destroy] do
      resources :comments, only: %i[index show create update destroy]
    end
  end
end
