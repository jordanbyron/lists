Lists::Application.routes.draw do

  root to: 'landing#index'

  match '/auth/:provider/callback',      to: 'sessions#create'
  match '/auth/failure',                 to: 'sessions#failure'
  match '/logout' => 'sessions#destroy', as: 'logout'
  match '/login'  => 'sessions#new',     as: 'login'

  resources :lists
  
  resources :gifts do
    member do 
      post :claim
      post :return
    end
  end
end
