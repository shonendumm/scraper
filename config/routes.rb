Rails.application.routes.draw do
  root 'scrape#index'

  get '/reddit', to: 'scrape#reddit'
  get '/orchardroad', to: 'scrape#diaryland'

  resources :diaries, only: [:index, :show]

end
