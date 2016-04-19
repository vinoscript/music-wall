class ChangeForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :tracks, :users
    add_reference :tracks, :user, index: true, foreign_key: true
  end
end
