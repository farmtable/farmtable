# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  person_id  :integer
#  items      :text
#  status     :integer          default(0)
#

require 'spec_helper'

describe Cart do
  pending "add some examples to (or delete) #{__FILE__}"
end
