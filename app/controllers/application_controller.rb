class ApplicationController < ActionController::Base
  # before_action :login_required
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private
  def login_required
    redirect_to sessions_new_path unless current_user
  end
end
