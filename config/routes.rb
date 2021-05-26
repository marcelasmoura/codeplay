Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :courses do
    resources :lectures
  end

  resources :teachers
end
