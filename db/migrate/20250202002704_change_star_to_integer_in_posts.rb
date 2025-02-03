class ChangeStarToIntegerInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :star, :integer
  end
end
