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

require 'spec_helper'

describe CartItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
