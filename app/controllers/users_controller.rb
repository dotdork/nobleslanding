class UsersController < ApplicationController

  before_action :require_signin
  before_action :require_correct_user, only: [:edit, :update, :destroy]
    
  def index
    @users = User.all
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
    @user.destroy
    # prolly need to check that current session matches current user
    session[:user_id] = nil
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
   params.require(:user).permit(:name,:email,:password,:password_confirmation)
 end
  
end


