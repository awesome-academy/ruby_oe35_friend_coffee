class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true

  before_save :set_unit_price, :set_total

  CARTITEM_ATTRS = %i(quantity product_id).freeze
  scope :order_item, ->{order created_at: :desc}

  validates :quantity, presence: true,
    numericality:
    {only_integer: true, greater_than: Settings.cart_item.validation.greater}

  def unit_price
    persisted? ? self[:unit_price] : product.price
  end

  def total
    unit_price * quantity
  end

  private

  def set_unit_price
    self.unit_price = unit_price
  end

  def set_total
    self.total = unit_price * quantity
  end
end
