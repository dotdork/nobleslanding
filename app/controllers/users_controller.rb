class UsersController < ApplicationController

  before_action :require_signin
  before_action :require_correct_user, only: [:edit, :update, :destroy, :show, :password]
  before_action :require_admin, only: [:index]
  before_action :get_relations
    
  def index
    case params[:cat]
    when 'Disabled'
      @users = User.where(relation_id: 'Disabled').order(:name).page(params[:page])
    when 'Admins'
      @users = User.where(admin: true).order(:name).page(params[:page])
    else
      @users = User.order(:name).page(params[:page])
    end
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
      redirect_to users_path, notice: "New user successfully added"
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
  
  def edita
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
      if current_user_admin?
        redirect_to(session[:intended_url] || users_path, notice: "User updated successfully")
      else
        redirect_to(session[:intended_url] || @user, notice: "User updated successfully")
      end
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
   params.require(:user).permit(:name,:email,:password,:password_confirmation, :relation_id, :admin, :pwchange)
 end
  
 def get_relations
   if current_user_admin?
     @relations = Relation.order(:name)
   else
     @relations = Relation.where(admin_only: false).order(:name)
   end
 end
end


