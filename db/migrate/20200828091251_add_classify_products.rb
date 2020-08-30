class AddClassifyProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :classify, :string, default: :life
  end
end
