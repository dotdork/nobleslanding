class GuestLogsController < ApplicationController
  
  def index
    @guest_logs = GuestLog.all_desc
    
    # calculate average rating
    @average = 0
    @guest_logs.each { |log| @average += log.rating }
    @average = @average / @guest_logs.size
    
  end
  
  def show
    @guest_log = GuestLog.find(params[:id])
  end
  
  def edit
    @guest_log = GuestLog.find(params[:id])
  end
  
  def update
    @guest_log = GuestLog.find(params[:id])
    @guest_log.update(guest_log_params)
    
    redirect_to @guest_log
  end
  
  def new
    @guest_log = GuestLog.new
  end
  
  
  def create
    # check in must be before check out date
    # check that dates are not in the future
#    now_time = Time.now
#    if params[:guest_log][:in_at] > now_time || params[:guest_log][:out_at] > now_time
#      "Invalid date provided"
#      redirect_to new_guest_log_path
#    end
    
    @guest_log = GuestLog.new(guest_log_params)
    @guest_log.save()
    redirect_to @guest_log
  end
  
  def destroy
    @guest_log = GuestLog.find(params[:id])
    @guest_log.destroy
    redirect_to guest_logs_path
  end
  
private 
  def guest_log_params
    params.require(:guest_log).
      permit(:name, :log, :in_at, :out_at, :rating)
  end


end
