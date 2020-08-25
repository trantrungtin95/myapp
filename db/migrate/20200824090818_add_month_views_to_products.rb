class AddMonthViewsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :month_views, :integer, default: 0
  end
end
