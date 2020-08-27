class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :page_number

      t.timestamps
    end
  end
end
