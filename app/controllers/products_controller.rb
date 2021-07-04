class ProductsController < ApplicationController
  before_action :find_product, only: %i(show)

  def index
    @products = Product.all.page(params[:page]).per Settings.home.page
    @cart_item = current_cart.cart_items.new
  end

  def show; end

  private

  def find_product
    @product = Product.find_by id: [params[:id]]
    return if @product

    flash.now[:danger] = "Not found product"
    redirect_to root_path
  end
end
