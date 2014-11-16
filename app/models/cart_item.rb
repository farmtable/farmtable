# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  owner_type :string(255)
#  quantity   :integer
#  item_id    :integer
#  item_type  :string(255)
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CartItem < ActiveRecord::Base
	acts_as_shopping_cart_item_for :cart
end
