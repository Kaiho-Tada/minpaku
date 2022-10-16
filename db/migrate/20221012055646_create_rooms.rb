class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.bigint :owner_id
      t.string :name, null: false
      t.string :place, null: false
      t.string :introduction 
      t.integer :price, null: false


      t.timestamps
    end
  end
end
