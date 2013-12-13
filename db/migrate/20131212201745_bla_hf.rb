class BlaHf < ActiveRecord::Migration
  def up
   change_table :readings do |t|
      t.change :liters, :decimal, :scale =>3
      t.change :measurement, :decimal, :scale => 3
    end
  end

  def down
  end
end
