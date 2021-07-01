class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_one :order, dependent: :destroy

  before_save :set_total_amount

  CART_ATTRS = %i(total_amount).freeze

  def total_amount
    cart_items.map do |cart_item|
      cart_item.quantity * cart_item.unit_price
    end.sum
  end

  private

  def set_total_amount
    self[:total_amount] = total_amount
  end
end
