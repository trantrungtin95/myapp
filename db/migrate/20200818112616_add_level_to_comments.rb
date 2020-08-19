class AddLevelToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :level, :integer, default: 0
  end
end
