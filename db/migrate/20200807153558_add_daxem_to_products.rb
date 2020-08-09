class AddDaxemToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :daxem, :integer
  end
end
