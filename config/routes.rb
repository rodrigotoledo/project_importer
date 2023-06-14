Rails.application.routes.draw do
  root 'imports#index'
  post 'import', to: 'imports#create', as: :import
  get 'imports', to: 'imports#index', as: :imports
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
