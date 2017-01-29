class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.valid?
      flash[:success] = "Phone number registered. Thank you!"
    else
      flash[:error] = "Invalid phone number. Please try again."
    end
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:phone)
  end

end
