class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone, null: false, limit: 100
      t.string :email
      t.timestamps null: false
    end
  end
end
