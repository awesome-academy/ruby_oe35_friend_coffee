class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      check_activated user
    else
      flash[:danger] = t "signin.flash.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to friendcoff_path
  end

  private

  def check_activated user
    if user.activated?
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:danger] = t "signin.flash.danger"
      redirect_to root_url
    end
  end
end
