class ChecklistsController < ApplicationController
  
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
    
  def index
    @checklists = Checklist.order(:name)
  end
  
  def show
    @checklist = Checklist.find(params[:id])
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
      permit(:name, :description, :checked)
  end

  
end
