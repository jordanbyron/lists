Lists::Application.routes.draw do

  #root to: 'home#index' TODO

  match '/auth/:provider/callback',      to: 'sessions#create'
  match '/auth/failure',                 to: 'sessions#failure'
  match '/logout' => 'sessions#destroy', as: 'logout'
  match '/login'  => 'sessions#new',     as: 'login'
end
