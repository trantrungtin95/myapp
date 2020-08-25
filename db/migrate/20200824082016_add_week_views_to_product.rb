class AddWeekViewsToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :week_views, :integer, default: 0
  end
end
