NoblesLanding::Application.routes.draw do
    root "home#index"
#    get "guest_logs" => "guest_logs#index"
#    get "guest_logs/:id" => "guest_logs#show", as: "guest_log"
#    get "guest_logs/:id/edit" => "guest_logs#edit", as: "edit_guest_log"
#    patch "guest_logs/:id" => "guest_logs#update"
      
    resources :guest_logs
    resources :checklists do
      resources :checklist_items
      get "checklist_items/:id/moveup" => "checklist_items#moveup", as: "moveup_checklist_item_path"
      get "checklist_items/:id/movedown" => "checklist_items#movedown", as: "movedown_checklist_item_path"
    end
    get "home/about" => "home#about"

end
