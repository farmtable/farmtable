class AddGrowingMethodToListings < ActiveRecord::Migration
  def change
    add_column :listings, :growing_method, :string
  end
end
