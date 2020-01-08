class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
  validates :commentable_id, presence: true

  default_scope -> { order(created_at: :asc) }
end
