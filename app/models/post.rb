class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true


  def favorited_by?(user)
    return false if user.nil?
    favorites.exists?(user_id: user.id)
  end
  
end
