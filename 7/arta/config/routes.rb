Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "enemy_targets#index"

  resources :enemy_targets
  resources :guns

end
