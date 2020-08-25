class AddDayViewsToMostViews < ActiveRecord::Migration[6.0]
  def change
    add_column :most_views, :day_views, :integer
  end
end
