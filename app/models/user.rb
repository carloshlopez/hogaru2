class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #validates :first_name, :last_name, presence: true
  has_many :announcements
  has_many :seen_announcements
  
  def name
    "#{self.last_name}, #{self.first_name}"
  end
  
end
