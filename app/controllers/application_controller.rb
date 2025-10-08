class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:alert] = "Please log in first."
      redirect_to login_path
    end
  end

  def require_admin
    if session[:role] != 'admin'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  def require_student
    unless session[:role] == "student"
      flash[:alert] = "Only students can do that."
      redirect_to root_path
    end
  end

  def require_mentor
    unless session[:role] == "mentor"
      flash[:alert] = "Only mentors can do that."
      redirect_to root_path
    end
  end

end
