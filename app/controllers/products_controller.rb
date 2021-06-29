class ProductsController < ApplicationController
  before_action :find_product, only: %i(show)

  def index
    @products = Product.all.page(params[:page]).per Settings.home.page
    @cart_item = current_cart.cart_items.new
  end

  def new
    @product = Product.new
  end

  def show; end

  def create
    @product = Product.new product_params
  end

  def update; end

  def destroy; end

  private

  def find_product
    @product = Product.find_by id: [params[:id]]
    return if @product

    flash.now[:danger] = "Not found product"
    redirect_to root_path
  end

  def product_params
    params.require(:product).permit Product::PRODUCT_ATTRS
  end
end
