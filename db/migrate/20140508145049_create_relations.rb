class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.string :name
      t.text :description
      t.boolean :admin_only

      t.timestamps
    end
  end
end
