class AddForeignKey < ActiveRecord::Migration
  def change
    add_foreign_key :tracks, :users
  end
end
