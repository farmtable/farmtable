# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#

class Cart < ActiveRecord::Base
	acts_as_shopping_cart_using :cart_item
  belongs_to :person
  serialize :items
end
