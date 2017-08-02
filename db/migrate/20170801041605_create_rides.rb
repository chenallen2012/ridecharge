class CreateRides < ActiveRecord::Migration[5.1]
  def change
    create_table :rides do |t|
      t.date :date
      t.float :price
      t.integer :rider_count
      t.text :rider_names
      t.boolean :ride_complete

      t.timestamps
    end
  end
end
