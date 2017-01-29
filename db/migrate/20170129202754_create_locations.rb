class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :level, null: false
      t.integer :parent_location_id
      t.timestamps null: false
    end
    create_table :locations_users do |t|
      t.integer :location_id
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :locations_users, [:location_id, :user_id]
    add_index :locations, :parent_location_id
  end
end
