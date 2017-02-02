class Admin::SmsController < Admin::BaseController

  def mass_send_new
  end

  def mass_send
  	locations = params[:locations].map { |location| Location.find_by(name: location) }
  	users = []
  	locations.each do |location|
  	  users += location.users
  	end
  	users.uniq!
  	users.each do |user|
  	  TwilioUtils.send_message(user, params[:content])
  	end
  	flash[:notice] = "Sent #{users.size} messages."
  	redirect_to admin_root_path
  end
end
