class AddCheckedToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :checked, :boolean, default: true
  end
end
