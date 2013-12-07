class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.datetime :date
      t.integer :measurement
      t.integer :liters

      t.timestamps
    end
  end
end
