class UsersController < ApplicationController

  class UserCreationError < StandardError; end
  class MissingLocationsError < StandardError; end

  def create
    begin
      raise MissingLocationsError if location_params[:locations].nil?
      locations = location_params[:locations].map { |location_name| Location.find_by(name: location_name) }
      raise MissingLocationsError if locations.size == 0
      ActiveRecord::Base.transaction do
        @user = User.create(user_params)
        @user.locations += locations
        raise UserCreationError if !@user.valid?
      end
      session[:user_id] = @user.id
      flash[:success] = "You have been subscribed to the service. Thank you!"
    rescue UserCreationError => e
      flash[:error] = "Invalid phone number. Please try again."
    rescue MissingLocationsError => e
      flash[:error] = "No locations selected. Please try again."      
    end
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:phone)
  end

  def location_params
    params.permit(locations: [])
  end

end
