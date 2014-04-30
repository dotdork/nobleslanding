class ChecklistItemsController < ApplicationController
  before_action :require_signin, except: [:index]
  before_action :require_admin, except: [:index]
    
  def index
    @checklist = Checklist.find(params[:event_id])
    @items = @checklist.checklist_items
  end
  
  def edit
    @checklist = Checklist.find(params[:checklist_id])
    @checklist_item = @checklist.checklist_items.find(params[:id])
  end
  
  def update
    @checklist = Checklist.find(params[:checklist_id])
    @checklist_item = @checklist.checklist_items.find(params[:id])
    if @checklist_item.update(checklist_item_params)
      redirect_to edit_checklist_path(@checklist), notice: "Checklist Item updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @checklist = Checklist.find(params[:checklist_id])
    @checklist.checklist_items.destroy(params[:id])
    ChecklistItem.resequence
    redirect_to edit_checklist_path(@checklist), notice: "Checklist Item deleted successfully"
  end
   
  def moveup
    @checklist = Checklist.find(params[:checklist_id])
    @checklist_item = ChecklistItem.find(params[:id])
    @checklist_item.moveup
    redirect_to edit_checklist_path(@checklist)
  end
  
  def movedown
    @checklist = Checklist.find(params[:checklist_id])
    @checklist_item = ChecklistItem.find(params[:id])
    @checklist_item.movedown
    redirect_to edit_checklist_path(@checklist)
  end
  
  def new
    @checklist = Checklist.find(params[:checklist_id])
    @checklist_item = @checklist.checklist_items.new
  end
  
  
  def create 
    @checklist = Checklist.find(params[:checklist_id])
    @checklist_item = @checklist.checklist_items.new(checklist_item_params)
    # set order to last
    last_item = ChecklistItem.get_last(params[:checklist_id])
    if last_item
      @checklist_item.seq = last_item.seq + 1
    else
      @checklist_item.seq = 0
    end
    
    if @checklist_item.save()
      redirect_to edit_checklist_path(@checklist), notice: "Checklist Item created successfully"
    else
      render :new
    end  
  end  
  
private 
  def checklist_item_params
    params.require(:checklist_item).
      permit(:name, :description, :seq)
  end
end
