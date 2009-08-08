# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def signed_in?
    ! current_user.nil?
  end
  
  def ensure_login
#    unless signed_in?
      flash[:notice] = "Please login to continue"
#      redirect_to(new_session_path)
#      redirect_to(root_path)
#    end
  end
  
  def redirect_to_root
    redirect_to(root_path)
  end

  def redirect_to_login
    redirect_to(root_path)
  end

  def current_user
    @_current_user ||= User.find_by_id(session[:user_id])
  end
  
 
end
