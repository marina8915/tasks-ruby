Rails.application.routes.draw do
  get 'home/index'
  get 'tasks/task_1'
  post 'tasks/result'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
