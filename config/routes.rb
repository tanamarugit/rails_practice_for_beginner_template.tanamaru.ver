Rails.application.routes.draw do
  get 'sessions/new', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :questions
  resources :users
end
