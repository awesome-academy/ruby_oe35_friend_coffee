class CartItemsController < ApplicationController
  before_action :new_cart, only: :create
  before_action :load_cart_item, only: %i(update destroy)

  def create
    if @cart_item.save
      session[:cart_id] = current_cart.id
      respond_to do |format|
        format.html{redirect_to products_path}
        format.js{flash.now[:notice] = t("flash.save_success")}
      end
    else
      flash.now[:danger] = t "flash.fail"
      redirect_to products_path
    end
  end

  def update
    if @cart_item.update cart_item_params
      respond_to do |format|
        @cart_items = current_cart.cart_items
        format.html{redirect_to carts_path}
        format.js{flash.now[:notice] = t("flash.update_done")}
      end
    else
      flash.now[:danger] = t "flash.fail"
      redirect_to carts_path
    end
  end

  def destroy
    if @cart_item.destroy
      respond_to do |format|
        @cart_items = current_cart.cart_items
        format.html{redirect_to carts_path}
        format.js{flash.now[:notice] = t("flash.destroy_done")}
      end
    else
      flash.now[:danger] = t "flash.destroy_fail"
      redirect_to carts_path
    end
  end

  private

  def load_cart_item
    @cart_item = current_cart.cart_items.find_by id: params[:id]
    return if @cart_item

    flash.now[:danger] = t "flash.not_found_cart"
    redirect_to products_path
  end

  def new_cart
    @cart_item = current_cart.cart_items.new cart_item_params
  end

  def cart_item_params
    params.require(:cart_item).permit CartItem::CARTITEM_ATTRS
  end
end
