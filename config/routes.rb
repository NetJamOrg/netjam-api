Rails.application.routes.draw do

  scope 'api' do

    get '/auth/:provider/callback', to: 'sessions#create'

    get '/login', to: redirect('/auth/google_oauth2')

    get '/logout', to: 'sessions#destroy'

    resources :projects, only: [ :index ] # for now
    resources :users, only: [ :index ]
    resources :clips, only: [ :index ]
    resources :songs, only: [ :index ]
  end
end
