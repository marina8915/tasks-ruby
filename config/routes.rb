Rails.application.routes.draw do
  get 'home/index'

  get 'tasks/:id', to: 'tasks#display'
  post 'tasks/result/:id', to: 'tasks#result'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
