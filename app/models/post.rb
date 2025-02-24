class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags
  
  validates :title, presence: true
  validates :body, presence: true
  validates :star, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true


  def favorited_by?(user)
    return false if user.nil?
    favorites.exists?(user_id: user.id)
  end

  # 検索処理
  def self.looks(word)
    where("title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%")
  end

# タグ処理
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

  
end
