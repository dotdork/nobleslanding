class AddManagerOnlyOnChecklists < ActiveRecord::Migration
  def up
    add_column :checklists, :manager_only, :boolean, default: false
  end
  
  def down
    remove_column :checklists, :manager_only
  end
end
