Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    resources :posts, only: %i[index show create update destroy] do
      resources :comments, only: %i[index create update destroy]
    end
  end
end
