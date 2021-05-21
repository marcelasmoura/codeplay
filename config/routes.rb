Rails.application.routes.draw do
  root 'home#index'
  resources :courses do
    resources :lectures
  end

  resources :teachers
end
