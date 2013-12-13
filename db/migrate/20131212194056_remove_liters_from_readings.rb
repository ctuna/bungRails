class RemoveLitersFromReadings < ActiveRecord::Migration
  def up
  remove_column :readings, :liters, :integer
   add_column :readings, :liters, :decimal, :precision => 3
  end

  def down
  end
end
