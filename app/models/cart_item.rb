class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true

  CARTITEM_ATTRS = %i(quantity product_id).freeze

  validates :quantity, presence: true,
    numericality:
    {only_integer: true, greater_than: Settings.cart_item.validation.greater}
end
