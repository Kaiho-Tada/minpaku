class AddColumnPortraitUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :portrait, :attachment
  end
end
