class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user 
    flash[:danger] = t ".usernotfound"
    redirect_to signup_path
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, 
      :password_confirmation
  end
end
