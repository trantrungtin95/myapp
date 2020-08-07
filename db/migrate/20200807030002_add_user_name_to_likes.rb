class AddUserNameToLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :user_name, :string
  end
end
