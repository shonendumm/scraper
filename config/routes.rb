Rails.application.routes.draw do
  root 'scrape#index'

  get '/reddit', to: 'scrape#reddit'
end
