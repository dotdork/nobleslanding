class GuestLogsController < ApplicationController
  before_action :require_signin, except: [:index, :show]

  def index
    @guest_logs = GuestLog.all_desc
    
    # calculate average rating
    @average = 0
    @guest_logs.each { |log| @average += log.rating }
    if @guest_logs.size == 0
      @average = "n/a"
    else
      @average = @average / @guest_logs.size
    end
    
  end
  
  def show
    @guest_log = GuestLog.find(params[:id])
  end
  
  def edit
    @guest_log = GuestLog.find(params[:id])
    require_same_name(@guest_log.user)
  end
  
  def update
    @guest_log = GuestLog.find(params[:id])
    require_same_name(@guest_log.user)
    if @guest_log.update(guest_log_params)
      redirect_to @guest_log, notice: "Guest Log updated successfully"
    else
      render :edit
    end
  end
  
  def new
    @guest_log = GuestLog.new
  end
  
  
  def create  
    @guest_log = GuestLog.new(guest_log_params)
    @guest_log.user = current_user
    if @guest_log.save
      redirect_to @guest_log, notice: "Guest Log created successfully"
    else
      render :new
    end  
    
  end
  
  def destroy
    @guest_log = GuestLog.find(params[:id])
    @guest_log.destroy
    redirect_to guest_logs_path, notice: "Guest Log deleted successfully"
  end
  
private 
  def guest_log_params
    params.require(:guest_log).
      permit(:name, :log, :in_at, :out_at, :rating)
  end
  
  def require_same_name(user)
    unless  current_user == user 
      redirect_to root_path, alert: "Unauthorized access!"
    end
  end


end
