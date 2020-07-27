class UpdateNotifications < ActiveRecord::Migration[4.2]
  def change
    remove_column :notifications, :owner
    remove_column :notifications, :join_project
    add_column :notifications, :join_request, :string
    
  end
end
