class AddPublicToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :public, :boolean, default: false
  end
end
