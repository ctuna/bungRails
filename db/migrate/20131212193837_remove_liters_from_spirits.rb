class RemoveLitersFromSpirits < ActiveRecord::Migration
  def up
   remove_column :spirits, :liters, :integer
   add_column :spirits, :liters, :decimal, :precision => 2
  end

  def down
  end
end
