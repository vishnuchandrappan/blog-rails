class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :content, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
  validates :post_id, presence: true

  default_scope -> { order(created_at: :asc) }
end
