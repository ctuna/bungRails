class AddTimeOfDayToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :timeOfDay, :String
  end
end
