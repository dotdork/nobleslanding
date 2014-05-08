class AddRelationIdToUsers < ActiveRecord::Migration
  def up
    add_column :users, :relation_id, :string
  end
  
  def down
    remove_column :users, :relation_id
  end
  
  
end
