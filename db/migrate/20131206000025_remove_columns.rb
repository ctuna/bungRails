class RemoveColumns < ActiveRecord::Migration
  def up
      remove_column :barrels, :container, :string
      remove_column :barrels, :contents, :string
      remove_column :barrels, :gallons, :integer

  end

  def down
  end
end
