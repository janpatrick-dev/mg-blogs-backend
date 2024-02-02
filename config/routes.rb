Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    resources :posts, only: %i[index show create] do
      resources :comments, only: %i[index]
    end
  end
end
