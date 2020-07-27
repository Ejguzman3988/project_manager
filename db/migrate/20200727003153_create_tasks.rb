class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.integer :project_id
      t.datetime :deadline
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
