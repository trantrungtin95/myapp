class AddWeekViewsToMostView < ActiveRecord::Migration[6.0]
  def change
    add_column :most_views, :week_views, :integer
  end
end
