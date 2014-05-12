class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    # authenticate with database   
    user = nil
    case params[:provider]
    when 'facebook'
      user = User.authenticate_facebook(env["omniauth.auth"])
    when 'google_oauth2'
      user = User.authenticate_google(env["omniauth.auth"])
    when 'google_refresh'
      user = User.authenticate_google_refresh(env["omniauth.auth"])
    else 
      user = User.authenticate_local(params[:email],params[:password])
    end

    if user
      if user.name == 'Nobles Landing'
        session[:noble_id] = user.id
        redirect_to(session[:intended_url] || calendar_path)
      else  
        if !user.disabled?
          session[:user_id] = user.id
          if user.pwchange?
            redirect_to edit_user_password_path(user), notice: "Please change your password!"
          else
            redirect_to(session[:intended_url] || root_path, notice: "Welcome back, #{user.name}!")
          end
        else
          if user.provider != 'local'
          flash.now[:alert] = "Account Disabled!  Please contact administrator to resolve.  If this is your first
            time signing in with a remote provider (facebook, google, etc), then an admin user will need to enable
            your account to give you full access to the site.  Or maybe your account was disabled for a reason."
          else
            flash.now[:alert] = "Account Disabled!  Please contact administrator to resolve."
          end          
          render :new       
        end
      end
    else
      flash.now[:alert] = "Invalid email or password combination!"
      render :new
    end

  end
  
  def destroy
    session[:user_id] = nil
    session[:noble_id] = nil
    session[:intended_url] = nil
    redirect_to root_path, notice: "Thanks, now go enjoy the beach!"
  end
  
  
end
