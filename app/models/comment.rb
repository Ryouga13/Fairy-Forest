class Comment < ApplicationRecord

  belong_to :user
  belong_to :post

  validates :comment, presence: true
  
end
