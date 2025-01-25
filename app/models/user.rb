class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true


  def active_for_authentication?
    super && (is_deleted == false)
  end

  GUEST_EMAIL = "guest@dmm.com"
  def self.guest
    find_or_create_by!(email: GUEST_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email == GUEST_EMAIL
  end


end
