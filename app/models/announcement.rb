class Announcement < ApplicationRecord
  belongs_to :user
  validates :text, :expiration_date, :user_id, presence: true
  validates :text, length: { maximum: 140 }
  has_many :seen_announcements
  
  scope :not_seen_not_expired, -> (user_id) { where("announcements.expiration_date > ? AND announcements.id NOT IN 
    (SELECT seen_announcements.announcement_id from seen_announcements where seen_announcements.user_id = #{user_id})", DateTime.now)}
end
