class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comments, dependent: :destroy
  
  validates :message, presence: true
end
