class Admin::AdminSessionsController < Admin::BaseController
  before_action :admin_user, only: :destroy

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      check_admin user
    else
      flash[:danger] = t "signin.flash.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to admin_root_path
  end

  private

  def check_admin user
    if user.admin?
      log_in user
    else
      flash[:danger] = t "signin.flash.danger"
    end
    redirect_to admin_root_url
  end

  def admin_user
    redirect_to admin_root_url unless current_user.admin?
  end
end
