Rails.application.routes.draw do
  get '/s/:slug', to: 'links#show', as: :short
  resources :links, only: [:new, :create, :index]
end
