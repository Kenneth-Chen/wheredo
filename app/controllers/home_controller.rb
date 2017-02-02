class HomeController < ApplicationController
  def index
    @user = User.new
  end

  def contact_us
    UserMailer.delay.contact_us(contact_us_params[:name], contact_us_params[:email], contact_us_params[:message])
    flash[:notice] = "Message sent! We should be in touch with you shortly."
    redirect_to root_path
  end

  private
  def contact_us_params
    params.permit(:name, :email, :message)
  end

end
