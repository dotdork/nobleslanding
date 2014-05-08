class AddRequireLoginToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :require_login, :boolean, default: false
  end
end
