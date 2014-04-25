class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.string :name
      t.text :description
      t.integer :order
      t.references :checklist, index: true

      t.timestamps
    end
  end
end
