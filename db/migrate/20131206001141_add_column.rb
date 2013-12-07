class AddColumn < ActiveRecord::Migration
  def up
  add_column :barrels, :name, :string

  end

  def down
  end
end
