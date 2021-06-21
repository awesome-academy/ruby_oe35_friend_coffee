class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update)
  before_action :find_user, except: %i(create new index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.user.index_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t "signup.flash.check_activate"
      redirect_to @user
    else
      flash.now[:danger] = t "flash.save_error"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "flash.not_found_user"
    redirect_to friendcoff_path
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "flash.update_done"
      redirect_to @user
    else
      flash.now[:danger] = t "flash.fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.destroy_done"
    else
      flash[:danger] = t "flash.destroy_fail"
    end
    redirect_to users_url
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "flash.not_found_user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit User::USER_PERMIT
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "flash.not_found_user"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
