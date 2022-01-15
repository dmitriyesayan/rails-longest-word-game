Rails.application.routes.draw do
  root to: 'pages#home'
  post 'results', to: 'pages#results'
end
