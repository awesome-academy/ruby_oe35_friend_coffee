module ApplicationHelper
  def full_title page_title
    base_title = t "base_title"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def save_cart cart
    session[:cart_id] = cart.id
  end

  def current_cart
    @current_cart ||= session_cart ? Cart.find(session[:cart_id]) : Cart.new
  end

  private

  def session_cart
    session[:cart_id].present?
  end
end
