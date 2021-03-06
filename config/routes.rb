Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'sessions#create'

  scope 'api' do

    get '/login', to: redirect('/auth/google_oauth2')

    get '/logout', to: 'sessions#destroy'

    resources :projects, only: [ :index ] # for now
    resources :users, only: [ :index ]
    resources :clips, only: [ :index ]
    resources :songs, only: [ :index ]
  end
end
