class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.save_success"
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

  private

  def user_params
    params.require(:user).permit User::USER_PERMIT
  end
end
