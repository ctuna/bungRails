class CreateBarrels < ActiveRecord::Migration
  def change
    create_table :barrels do |t|
      t.string :container
      t.string :contents
      t.decimal :gallons

      t.timestamps
    end
  end
end
