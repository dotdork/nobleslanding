NoblesLanding::Application.routes.draw do

  root "home#index"
  get "about" => "home#about"
  get "history" => "home#history"
  get "bolivar" => "home#bolivar"
  get "calendar" => "home#calendar"

  get "users/cat/:cat" => "users#index", as: "users_limited"
  resources :users
  get "signup" => "users#new"
  get "/users/:id/password" => "users#password", as: "edit_user_password"
  get "/users/:id/edita" => "users#edita", as: "edita_user"

  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => 'home#index'
  get 'signout' => 'sessions#destroy', as: 'signout'

  resources :guest_logs
  resources :relations
  
  get "checklists/manage" => "checklists#manage", as: "manage_checklists"
  get "checklists/manager/index" => "checklists#manager_index", as: "manager_checklists"
  get "checklists/manager/manage" => "checklists#manager_manage", as: "manager_manage_checklists"
  get "checklists/manager/new" => "checklists#manager_new", as: "new_manager_checklist"
  resources :checklists do
    resources :checklist_items
    get "checklist_items/:id/moveup" => "checklist_items#moveup", as: "moveup_checklist_item"
    get "checklist_items/:id/movedown" => "checklist_items#movedown", as: "movedown_checklist_item"
  end
 
  resource :session
  get "login" => "sessions#new"
end
