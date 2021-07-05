class Order < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :user

  enum order_status: {pending: 0, confirm: 1, delivered: 2}

  ORDER_ATTRS = %i(user_id cart_id order_price address city phone).freeze
end
