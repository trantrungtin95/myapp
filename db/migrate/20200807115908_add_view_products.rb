class AddViewProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :product, :view, :integer
  end
end
