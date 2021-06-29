class CartsController < ApplicationController
  def index
    @cart_items = current_cart.cart_items.order_item
    @order = current_cart.order
  end

  def show
    @cart_items = current_cart.cart_items
  end

  private

  def cart_params
    params.require(:cart).permit Cart::CART_ATTRS
  end
end
