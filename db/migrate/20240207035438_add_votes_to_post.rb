class AddVotesToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :votes, :jsonb, default: { upvotes: [], downvotes: [] }
    add_column :comments, :votes, :jsonb, default: { upvotes: [], downvotes: [] }
  end
end
