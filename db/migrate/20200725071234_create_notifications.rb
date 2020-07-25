class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :project_id
      t.boolean :join_project
      t.boolean :owner

      t.timestamps null: false
    end
  end
end
