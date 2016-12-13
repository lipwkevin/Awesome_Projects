Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/about/' => 'welcome#about', as: :about

  resources :users, only: [:create, :new]
  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

  resources :projects, shallow:true do
    resources :goals do
      resources :tasks
    end
  end
  get '/member/edit/:id', to: 'projects#listMember', as: :editMember
  post '/member/edit/:id', to: 'projects#editMember'
  post '/member/update/:id' , to: 'projects#updateMember', as: :updateMember
  post '/member/remove/:id', to: 'projects#removeMember', as: :removeMember
  get '/projects/delete/:id', to: 'projects#deleteAllGoal', as: :deleteAll
  get '/projects/:id/update_now', to: 'projects#check_update', as: :project_update

  get '/updateFlag/:id', to: 'tasks#setFlag', as: :task_flag
  post '/updateComplete/:id', to: 'tasks#setComplete', as: :task_complete
  post '/updateTask/:id', to: 'tasks#relocateTask', as: :sort_task

  get '/logs/:id', to: 'logs#index', as: :logs
  get '/logs/history/:id', to: 'logs#show', as: :show_logs
  post '/logs/:id/new', to: 'logs#create', as: :new_log

  get '/generate/share/:id', to: 'tokens#createShare', as: :share_project
  get '/token/:hex', to: 'tokens#show', as: :show_token

  get '/message/new/:id', to: 'messages#new', as: :new_message
  post '/message/new/:id', to: 'messages#create'
  get '/message/:id', to: 'messages#show', as: :show_message
  post '/message/:id', to: 'messages#conversation'
  get '/message/', to: 'messages#index', as: :list_message
end
