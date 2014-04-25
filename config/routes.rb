NoblesLanding::Application.routes.draw do

  NoblesLanding::Application.routes.draw do
    root "home#index"
#    get "guest_logs" => "guest_logs#index"
#    get "guest_logs/:id" => "guest_logs#show", as: "guest_log"
#    get "guest_logs/:id/edit" => "guest_logs#edit", as: "edit_guest_log"
#    patch "guest_logs/:id" => "guest_logs#update"
    
    resources :guest_logs
    resources :checklists
    get "home/about" => "home#about"
    
  end

end
