class UsersController < ApplicationController

  before_action :require_signin
  before_action :require_correct_user, only: [:edit, :update, :destroy, :show]
  before_action :require_admin, only: [:index]
    
  def index
    @users = User.order(:name)
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
    
    redirect_to guest_logs_path, notice:  "User was deleted"
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "User updated successfully"
    else
      render :edit
    end
  end
      
private
 def user_params
   params.require(:user).permit(:name,:email,:password,:password_confirmation, :relation, :admin)
 end
  
end


