class AddItemsToCart < ActiveRecord::Migration
  def change
    add_column :carts, :items, :text
  end
end
