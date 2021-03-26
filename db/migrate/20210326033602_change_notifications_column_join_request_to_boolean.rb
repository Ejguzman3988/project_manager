class ChangeNotificationsColumnJoinRequestToBoolean < ActiveRecord::Migration[6.1]
  def change
    change_column :notifications, :join_request, 'boolean USING CAST(join_request AS boolean)'
  end
end
