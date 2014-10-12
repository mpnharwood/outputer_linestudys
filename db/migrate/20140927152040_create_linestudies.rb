class CreateLinestudies < ActiveRecord::Migration
  def change
    create_table :linestudies do |t|
      t.string :name
      t.string :description
      t.string :type
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
    add_index :linestudies, [:user_id, :created_at]
  end
end
