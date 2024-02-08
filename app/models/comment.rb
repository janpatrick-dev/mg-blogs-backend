class Comment < ApplicationRecord
  after_save :update_votes_count

  belongs_to :user
  belongs_to :post
  has_many :comments, dependent: :destroy
  
  validates :message, presence: true

  def votes_count
    upvotes_count = self.votes['upvotes'].length
    downvotes_count = self.votes['downvotes'].length
    upvotes_count - downvotes_count
  end
  
  private

  def update_votes_count
    upvotes_count = self.votes['upvotes'].length
    downvotes_count = self.votes['downvotes'].length
    self.update_column(:votes_count, upvotes_count - downvotes_count)
  end
end
