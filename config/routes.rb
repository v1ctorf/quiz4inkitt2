Rails.application.routes.draw do
  # get 'welcome/index'
  resources :answers

  root 'welcome#index'
end
