class AddColumnsToGuestLog < ActiveRecord::Migration
  def change
    add_column :guest_logs, :in_at, :date
    add_column :guest_logs, :out_at, :date
  end
end
