class Admin::ProductsController < Admin::BaseController
  def index
    @products = Product.all
  end
end
