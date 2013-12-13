class AddCyclesToBarrels < ActiveRecord::Migration
  def change
    add_column :barrels, :cycles, :integer
  end
end
