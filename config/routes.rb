Lists::Application.routes.draw do
  root to: 'landing#index'

  match '/auth/:provider/callback',      to: 'sessions#create', via: [:get, :post]
  get   '/auth/failure',                 to: 'sessions#failure'
  get   '/logout' => 'sessions#destroy', as: 'logout'
  get   '/login'  => 'sessions#new',     as: 'login'

  resources :identities

  resources :lists

  resources :gifts do
    member do
      post   :claim
      post   :return
      match  :purchase, via: [:get, :post]
    end
  end

  get '/shopping_list', to: 'accounts#shopping_list', as: 'shopping_list'

  resource :account do
    member do
      get :setup
      get :link_to_existing_user
    end
  end

  post '/invites/:id/resend' => 'invites#resend', as: 'resend_invite'

  resources :password_resets
end
