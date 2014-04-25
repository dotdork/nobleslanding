class CreateGuestLogs < ActiveRecord::Migration
  def change
    create_table :guest_logs do |t|
      t.string :name
      t.string :log
      t.datetime :date

      t.timestamps
    end
  end
end
