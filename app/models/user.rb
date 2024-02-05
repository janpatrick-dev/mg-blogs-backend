class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :posts
  has_many :comments

  validates :username, presence: true, length: { minimum: 3, maximum: 20 }
  validates :name, presence: true

  def jwt_payload
    super
  end
end
