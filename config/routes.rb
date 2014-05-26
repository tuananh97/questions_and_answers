Rails.application.routes.draw do
  resources :votes

  devise_for :views
  devise_for :users
  resources :comments

  root "questions#index"

  get "/about_us"           => "home#about"
  get "/faq"                => "faq#index"
  get "/help"               => "help#index"

  get "/questions"          => "questions#index"

  post "/questions"         => "questions#create"
  get "/questions/new"      => "questions#new"
  get "/questions/:id"      => "questions#show"
  get "/questions/:id/edit" => "questions#edit"
  match "/questions/:id"    => "questions#update", via: [:put, :patch]
  delete "/questions/:id"   => "questions#destroy"

  resources :questions do
    resources :votes, only: [:create, :edit, :destroy]
    resources :answers
    member do
      post :vote_up
      post :vote_down
    end
    post :search, on: :collection
  end

end
