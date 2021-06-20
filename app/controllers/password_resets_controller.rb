class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:infor] = t "signin.forget_pass.flash_success"
      redirect_to root_url
    else
      flash.now[:danger] = t "signin.forget_pass.flash_danger"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t("signin.forget_pass.flash_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t "signin.forget_pass.flash_success"
      redirect_to @user
    else
      flash.now[:danger] = t "signin.forget_pass.flash_danger"
      render :edit
    end
  end

  private

  def user_params
    params.required(:user).permit User::PASSWORD_ATTRS
  end

  def get_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "signin.forget_pass.flash_danger"
    redirect_to root_url
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "signin.forget_pass.flash_expired"
    redirect_to new_password_reset_url
  end
end
