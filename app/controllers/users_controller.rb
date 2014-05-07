class UsersController < ApplicationController

  before_action :require_signin
  before_action :require_correct_user, only: [:edit, :update, :destroy, :show, :password]
  before_action :require_admin, only: [:index]
    
  def index
    @users = User.order(:name)
    
    @all_emails = User.uniq.pluck(:email)
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "New user successfully added"
    else
      render :new
    end
  end

  def password
    @user = User.find(params[:id])
  end
  
   
  def edit
    @user = User.find(params[:id])
  end 

  def destroy
    @user = User.find(params[:id])
    if session[:user_id] && User.find(session[:user_id]) == @user
      destroy_session = true
    end
    
    @user.destroy
    
    if destroy_session
      session[:user_id] = nil
    end
    
    if current_user_admin?
      redirect_to users_path, notice:  "User was deleted"
    else
      redirect_to root_path, notice:  "User was deleted"
    end
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password] && current_user == @user
      params[:user][:pwchange] = false
    end
    if @user.update(user_params)
      redirect_to(session[:intended_url] || @user, notice: "User updated successfully")
    else
      if params[:user][:password]
        render :password
      else
        render :edit
      end
    end
  end
      
private
 def user_params
   params.require(:user).permit(:name,:email,:password,:password_confirmation, :relation, :admin, :pwchange)
 end
  
end


