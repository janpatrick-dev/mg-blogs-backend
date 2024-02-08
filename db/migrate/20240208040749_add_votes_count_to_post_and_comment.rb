class AddVotesCountToPostAndComment < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :votes_count, :integer, default: 0
    add_column :comments, :votes_count, :integer, default: 0

    Post.find_each do |post|
      upvotes_count = post.votes['upvotes'].length
      downvotes_count = post.votes['downvotes'].length
      post.update_columns(votes_count: upvotes_count - downvotes_count)
    end

    Comment.find_each do |comment|
      upvotes_count = comment.votes['upvotes'].length
      downvotes_count = comment.votes['downvotes'].length
      comment.update_columns(votes_count: upvotes_count - downvotes_count)
    end
  end
end
