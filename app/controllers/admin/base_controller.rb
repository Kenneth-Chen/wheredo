class Admin::BaseController < ApplicationController

  before_action :admin_only!

  layout "admin/base"

  private

  def admin_only!
    # redirect_to root_url unless current_user.admin?
  end
end
