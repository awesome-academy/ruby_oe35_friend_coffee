class Admin::MainPagesController < Admin::BaseController
  before_action :logged_in_user, :admin_user

  def dashboard; end

  private

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "flash.not_found_user"
    redirect_to admin_signin_url
  end

  def admin_user
    return if current_user.admin?

    log_out
    flash[:danger] = t "signin.flash.danger"
    redirect_to admin_signin_url
  end
end
