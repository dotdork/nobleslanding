class ChangeTypeToGuestLog < ActiveRecord::Migration
  def change
    change_column :guest_logs, :log, :text
  end
end
