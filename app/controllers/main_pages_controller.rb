class MainPagesController < ApplicationController
  def home
    @categories = Category.all
    @products = Product.all.page(params[:page]).per Settings.home.page
    @cart_item = current_cart.cart_items.new
  end

  def about; end
end
