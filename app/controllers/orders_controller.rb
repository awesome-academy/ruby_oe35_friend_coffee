class OrdersController < ApplicationController
  layout "layouts/order/application"

  before_action :authenticate_user
  before_action :load_order, only: %i(show)
  before_action :check_valid_cart

  def new
    @order = Order.new
    @cart_items = current_cart.cart_items
  end

  def show; end

  def create
    @order = current_user.orders.build order_params
    if @order.save
      session.delete :cart_id
      flash[:success] = t "flash.save_success"
      redirect_to root_path
    else
      flash.now[:danger] = t "flash.fail"
      redirect_to carts_path
    end
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t "flash.fail"
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit Order::ORDER_ATTRS
  end

  def check_valid_cart
    redirect_to products_path if current_cart.blank?
  end

  def authenticate_user
    redirect_to signin_path unless logged_in?
    store_location
  end
end
