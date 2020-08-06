class AddLikeToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :like, :integer
  end
end
