class CartItem < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :cart, optional: true

  validates :quantity, presence: true,
    numericality:
    {only_integer: true, greater_than: Settings.cart_item.validation.greater}
end
