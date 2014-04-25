class ChecklistsController < ApplicationController
  def index
    @checklists = Checklist.order(:name)
  end
  
  def show
    @checklist = Checklist.find(params[:id])
  end
  
  def edit
    @checklist = Checklist.find(params[:id])
  end
  
  def update
    @checklist = Checklist.find(params[:id])
    @checklist.update(checklist_params)
    
    redirect_to @checklist
  end
  
  def new
    @checklist = Checklist.new
  end
  
  
  def create 
    @checklist = Checklist.new(checklist_params)
    @checklist.save()
    redirect_to @checklist
  end
  
  def destroy
    @checklist = Checklist.find(params[:id])
    @checklist.destroy
    redirect_to checklists_path
  end
  
private 
  def checklist_params
    params.require(:checklist).
      permit(:name, :description)
  end

  
end
