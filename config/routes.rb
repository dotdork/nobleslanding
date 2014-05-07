NoblesLanding::Application.routes.draw do

  root "home#index"
  get "about" => "home#about"
  get "history" => "home#history"
  get "bolivar" => "home#bolivar"

  resources :users
  get "signup" => "users#new"
  get "/users/:id/password" => "users#password", as: "edit_user_password"


  resources :guest_logs
  
  resources :checklists do
    resources :checklist_items
    get "checklist_items/:id/moveup" => "checklist_items#moveup", as: "moveup_checklist_item_path"
    get "checklist_items/:id/movedown" => "checklist_items#movedown", as: "movedown_checklist_item_path"
  end

  resource :session
  get "login" => "sessions#new"
end
