class RemoveVotesFromPostAndComment < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :votes
    remove_column :posts, :votes
  end
end
