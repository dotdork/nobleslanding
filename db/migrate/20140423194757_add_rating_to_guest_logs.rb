class AddRatingToGuestLogs < ActiveRecord::Migration
  def change
    add_column :guest_logs, :rating, :integer, default: 10
  end
end
