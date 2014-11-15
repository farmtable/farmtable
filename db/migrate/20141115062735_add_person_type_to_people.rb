class AddPersonTypeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :person_type, :integer, :default => 0
  end
end
