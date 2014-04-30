class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    # authenticate with database    
    if user = User.authenticate(params[:email],params[:password])
      session[:user_id] = user.id
      redirect_to(session[:intended_url] || root_path, notice: "Welcome back, #{user.name}!")
    else
      flash.now[:alert] = "Invalid email or password combination!"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:intended_url] = nil
    redirect_to root_path, notice: "Thanks, go enjoy the beach!"
  end
  
  
end
