class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  
    def require_signin
      session[:intended_url] = nil
      unless current_user
        session[:intended_url] = request.url
        redirect_to new_session_url, alert: "Please sign in first!"
      end
    end
    
    def current_user
      if session[:user_id]
        if !@current_user 
          if !@current_user = User.find_by(id: session[:user_id])
            session[:user_id] = nil
          end
        end
        @current_user
      end
    end
    helper_method :current_user
    
    def current_checklists
      if current_user
        @checklists = Checklist.order(:name)
      else
        @checklists = Checklist.where(require_login: false).order(:name)
      end
    end
    helper_method :current_checklists
    
    def require_correct_user
      # also allow admin
      unless  current_user_admin? || current_user?(User.find(params[:id]))
        redirect_to root_path, alert: "Unauthorized access!"
      end
    end
    
    def current_user?(user)
      current_user == user
    end
    helper_method :current_user?
    
    def require_admin
      unless current_user_admin?
        redirect_to root_url, alert: "Unauthorized access!"
      end
    end
    
    def current_user_admin?  
      current_user && current_user.admin?
    end
    helper_method :current_user_admin?
end
