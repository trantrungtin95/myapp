class CreateBookcases < ActiveRecord::Migration[6.0]
  def change
    create_table :bookcases do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
