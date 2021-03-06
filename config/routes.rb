Rails.application.routes.draw do
  get 'tasks/index'

  get 'tasks/:id', to: 'tasks#task', as: 'task'
  post 'tasks/result/:id', to: 'tasks#result'

  root 'tasks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
