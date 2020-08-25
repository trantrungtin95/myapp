class AddWeekviewsProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :weekviews, :integer, default: 0
  end
end
