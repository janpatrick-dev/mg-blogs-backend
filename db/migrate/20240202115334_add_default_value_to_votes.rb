class AddDefaultValueToVotes < ActiveRecord::Migration[7.1]
  def change
    change_column_default :posts, :votes, 0
    change_column_default :comments, :votes, 0
  end
end
