class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def confirm_user_cohort
    if current_user.cohort == nil
      redirect_to edit_user_path(current_user)
    end
  end
  helper_method :confirm_user_cohort
end
