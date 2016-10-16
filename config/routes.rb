Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get '/auth/:provider/callback', to: 'sessions#create'

  resources :projects, only: [ :index ] # for now
  resources :users, only: [ :index, :create ]
  resources :clips, only: [ :index ]
  resources :songs, only: [ :index ]
end
