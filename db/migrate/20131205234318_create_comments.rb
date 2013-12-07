class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.datetime :date
      t.string :author

      t.timestamps
    end
  end
end
