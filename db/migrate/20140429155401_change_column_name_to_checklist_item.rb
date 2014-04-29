class ChangeColumnNameToChecklistItem < ActiveRecord::Migration
  def change
    rename_column :checklist_items, :order, :seq
  end
end
