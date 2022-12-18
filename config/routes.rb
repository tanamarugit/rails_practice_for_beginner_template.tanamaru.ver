Rails.application.routes.draw do
  get 'sessions/new', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  

  resources :questions do 
    collection do
      get :solved
      get :unsolved
    end

    member do
      post :solve
    end

    resources :answers, only: [:create, :destroy]
  end


  resources :users
end
