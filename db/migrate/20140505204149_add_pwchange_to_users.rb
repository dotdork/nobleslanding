class AddPwchangeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pwchange, :boolean, default: false
  end
end
