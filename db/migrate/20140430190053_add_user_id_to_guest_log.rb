class AddUserIdToGuestLog < ActiveRecord::Migration
  def up
    GuestLog.delete_all
    add_column :guest_logs, :user_id, :string
  end
  
  def down
    GuestLog.delete_all
    remove_column :guest_logs, :user_id
  end
end
