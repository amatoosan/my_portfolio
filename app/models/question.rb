class Question < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 25 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true

end
