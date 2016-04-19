class ChangeForeignKey2 < ActiveRecord::Migration
  def change
    remove_index :tracks, :users_id if index_exists?(:tracks, :users_id)
    remove_column :tracks, :users_id
  end
end
