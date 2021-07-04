class Admin::ProductsController < Admin::BaseController
  before_action :load_product, except: %i(index new create)

  def index
    @products = Product.all.page(params[:page]).per Settings.admin.product_page
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "flash.save_success"
      redirect_to admin_products_path
    else
      flash[:danger] = t "flash.fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t "flash.update_done"
      redirect_to admin_products_path
    else
      flash.now[:danger] = t "flash.update_fail"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      respond_to do |format|
        format.html{redirect_to admin_products_path}
        format.js
      end
    else
      flash.now[:danger] = t "flash.update_fail"
      redirect_to admin_products_path
    end
  end

  private

  def product_params
    params.require(:product).permit Product::PRODUCT_ATTRS
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash.now[:danger] = t "flash.not_found_product"
    redirect_to admin_products_path
  end
end
