class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    # authenticate with database    
    if user = User.authenticate(params[:email],params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid email or password combination!"
      render :new
    end
  end
  
  
end
