class AddRfidToBarrels < ActiveRecord::Migration
  def change
    add_column :barrels, :RFID, :string
  end
end
