class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    # authenticate with database   
    user = nil
    case params[:provider]
    when 'facebook'
      user = User.authenticate_facebook(env["omniauth.auth"])
    else user = User.authenticate_local(params[:email],params[:password])
    end

    if user
      if !user.disabled?
        session[:user_id] = user.id
        if user.pwchange?
          redirect_to edit_user_password_path(user), notice: "Please change your password!"
        else
          redirect_to(session[:intended_url] || root_path, notice: "Welcome back, #{user.name}!")
        end
      else
        flash.now[:alert] = "User Disabled!  Please contact administrator to resolve"
        render :new       
      end
    else
      flash.now[:alert] = "Invalid email or password combination!"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:intended_url] = nil
    redirect_to root_path, notice: "Thanks, now go enjoy the beach!"
  end
  
  
end
