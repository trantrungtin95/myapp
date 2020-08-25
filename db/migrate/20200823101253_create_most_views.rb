class CreateMostViews < ActiveRecord::Migration[6.0]
  def change
    create_table :most_views do |t|
      t.integer :product_id
      t.string :kind
      t.integer :postion

      t.timestamps
    end
  end
end
