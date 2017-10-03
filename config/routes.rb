Rails.application.routes.draw do
  resources :answers
  root 'welcome#index'
  get 'list', to: "answers#list"
  
end
