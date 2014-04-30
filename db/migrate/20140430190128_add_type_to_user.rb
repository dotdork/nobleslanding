class AddTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :relation, :string
  end
end
