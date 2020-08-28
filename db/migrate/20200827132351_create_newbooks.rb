class CreateNewbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :newbooks do |t|
      t.integer :product_id

      t.timestamps
    end
  end
end
