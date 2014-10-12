class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :event_start
      t.datetime :event_stop
      t.string :event_description
      t.string :status
      t.decimal :speed
      t.integer :linestudy_id
      t.integer :js_id

      t.timestamps
    end
    add_index :events, [:linestudy_id, :created_at, :js_id]
  end
end
