class AddForeignKey < ActiveRecord::Migration
  def change
    add_reference :tracks, :users, index: true
    add_foreign_key :tracks, :users
  end
end
