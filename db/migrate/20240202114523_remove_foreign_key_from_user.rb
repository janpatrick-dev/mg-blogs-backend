class RemoveForeignKeyFromUser < ActiveRecord::Migration[7.1]
  def change
    remove_reference :users, :posts, foreign_key: true
  end
end
