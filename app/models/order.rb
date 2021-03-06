class Order < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :user

  ORDER_ATTRS = %i(name email).freeze
end
