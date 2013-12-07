class Change < ActiveRecord::Migration
  def up
      remove_column :barrels, :type, :string
      add_column :barrels, :shape, :string
  end

  def down
  end
end
