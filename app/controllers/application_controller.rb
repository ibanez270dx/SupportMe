class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def require_user
    unless current_user
      flash[:notice] = "You have to log in."
      session[:user_id] = nil
      redirect_to home_path and return false
    end
  end

end
