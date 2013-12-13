class Blah < ActiveRecord::Migration
  def up
change_column :readings, :liters, :decimal, :precision => 5
  end

  def down
  end
end
