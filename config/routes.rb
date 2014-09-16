Rails.application.routes.draw do
  apipie
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}

  #resources :items, defaults: {format: :json}

  resources :expenses, defaults: {format: :json}
  
  # You can have the root of your site routed with "root"
  root 'expenses#index'
  
end
