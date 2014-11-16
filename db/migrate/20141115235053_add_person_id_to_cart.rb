class AddPersonIdToCart < ActiveRecord::Migration
  def change
    add_column :carts, :person_id, :integer
  end
end
