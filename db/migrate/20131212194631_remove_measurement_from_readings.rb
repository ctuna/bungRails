class RemoveMeasurementFromReadings < ActiveRecord::Migration
  def up
    remove_column :readings, :measurement
    add_column :readings, :measurement, :decimal, :precision => 3
      end

  def down
    add_column :readings, :measurement, :integer
  end
end
