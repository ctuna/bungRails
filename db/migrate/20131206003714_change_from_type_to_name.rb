class ChangeFromTypeToName < ActiveRecord::Migration
  def up
      remove_column :spirits, :type, :string
      add_column :spirits, :name, :string
  end

  def down
  end
end
