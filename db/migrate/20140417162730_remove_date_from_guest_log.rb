class RemoveDateFromGuestLog < ActiveRecord::Migration
  def change
    remove_column :guest_logs, :date, :datetime
  end
end
