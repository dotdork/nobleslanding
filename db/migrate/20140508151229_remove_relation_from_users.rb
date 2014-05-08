class RemoveRelationFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :relation
  end
  
  def down
    add_column :users, :relation, :string
  end
end
