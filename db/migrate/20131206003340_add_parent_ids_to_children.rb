class AddParentIdsToChildren < ActiveRecord::Migration
  def change
  add_column :spirits, :barrel_id, :integer
  add_column :readings, :spirit_id, :integer
  add_column :comments, :spirit_id, :integer

  end
end
