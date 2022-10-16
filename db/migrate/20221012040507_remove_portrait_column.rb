class RemovePortraitColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :portrait, :attachment
  end
end
