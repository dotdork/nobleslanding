class ChecklistsController < ApplicationController
  
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :require_manager, only: [:manager_index]
    
  def index
    if current_user
      @checklists = Checklist.where(manager_only: false).order(:name).page(params[:page])
    else
      @checklists = Checklist.where(require_login: false, manager_only: false).order(:name).page(params[:page])
    end
  end

  def manage
    if current_user
      @checklists = Checklist.where(manager_only: false).order(:name).page(params[:page])
    else
      @checklists = Checklist.where(require_login: false, manager_only: false).order(:name).page(params[:page])
    end
  end

  def manager_index
    @checklists = Checklist.where(manager_only: true).order(:name).page(params[:page])
  end
  
  def manager_manage
    @checklists = Checklist.where(manager_only: true).order(:name).page(params[:page])
  end

  def show
    @checklist = Checklist.find(params[:id])
    if @checklist.require_login
      require_signin
    end
    
    if @checklist.manager_only
      require_manager
    end
    @items = @checklist.checklist_items.order(:seq)    
  end
  
  def edit
    @checklist = Checklist.find(params[:id])
    @items = @checklist.checklist_items.order(:seq)
  end
  
  def update
    @checklist = Checklist.find(params[:id])
    @items = @checklist.checklist_items.order(:seq)
    if @checklist.update(checklist_params)
      redirect_to @checklist, notice: "Checklist updated successfully"
    else
      render :edit
    end
  end
  
  def new
    @checklist = Checklist.new
  end
 
  def manager_new
    @checklist = Checklist.new
    @checklist.manager_only = true
    @checklist.require_login = true
  end 
  
  def create 
    @checklist = Checklist.new(checklist_params)
    if @checklist.save()
      redirect_to @checklist, notice: "Checklist created successfully"
    else
      render :new
    end  
  end
  
  def destroy
    @checklist = Checklist.find(params[:id])
    @checklist.destroy
    redirect_to checklists_path, notice: "Checklist deleted successfully"
  end
  
private 
  def checklist_params
    params.require(:checklist).
      permit(:name, :description, :checked, :require_login, :manager_only)
  end

  
end
