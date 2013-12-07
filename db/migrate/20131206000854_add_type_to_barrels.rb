class AddTypeToBarrels < ActiveRecord::Migration
  def change
    add_column :barrels, :type, :string
  end
end
