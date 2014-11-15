class AddUserTypeToPeople < ActiveRecord::Migration
  def change
		add_column :people, :user_type, :integer, :default => 0 
  end
end
