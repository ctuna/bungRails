class RemoveTimeOfDayFromReadings < ActiveRecord::Migration
  def up
     remove_column :readings, :timeOfDay

  end

  def down
  end
end
