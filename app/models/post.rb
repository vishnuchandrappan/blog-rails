class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable
  validates :user_id, presence:true
  validates :title, presence:true, length: { maximum: 140 }
  validates :body, presence:true, length: { maximum: 255 }

  default_scope -> { order(created_at: :desc) }
end
