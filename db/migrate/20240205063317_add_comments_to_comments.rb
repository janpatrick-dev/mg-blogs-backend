class AddCommentsToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :comment, foreign_key: true
  end
end
