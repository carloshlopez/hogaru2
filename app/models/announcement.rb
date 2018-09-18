class Announcement < ApplicationRecord
  belongs_to :user
  validates :text, :expiration_date, :user_id, presence: true
  validates :text, length: { maximum: 140 }
  has_many :seen_announcements
end
