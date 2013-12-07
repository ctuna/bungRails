class ChangeNameOfType < ActiveRecord::Migration
  def up
      remove_column :barrels, :type, :string
      add_column :barrels, :type,  :string
  end

  def down
  end
end
