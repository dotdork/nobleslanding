class RelationsController < ApplicationController
  before_action :require_admin
  
  def index
    @relations = Relation.order(:name)
  end
  
  def new
    @relation = Relation.new
  end

  def edit
    @relation = Relation.find(params[:id])
    if @relation.disabled?
      redirect_to relations_path, alert: "This user category cannot be modified"
    end
  end

  def update
    @relation = Relation.find(params[:id])
    if @relation.update(relation_params)
      redirect_to relations_path, notice: "User Category updated successfully"
    else
      render :edit
    end
  end
      
  def create  
    @relation = Relation.new(relation_params)
    if @relation.save
      redirect_to relations_path, notice: "User Category created successfully"
    else
      render :new
    end     
  end  
  
  def destroy
    @relation = Relation.find(params[:id])
    if @relation.disabled?
      redirect_to relations_path, alert: "This user category cannot be deleted"
    end
    @relation.destroy
    redirect_to relations_path, notice: "User Category deleted successfully"
  end  
  
  private 
    def relation_params
      params.require(:relation).
        permit(:name, :description, :admin_only)
    end
  
end
