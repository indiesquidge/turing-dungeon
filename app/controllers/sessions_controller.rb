class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(request.env["omniauth.auth"])
    if user
      if user.cohort == nil
        redirect_to edit_user_path(user)
      else
        session[:user_id] = user.id
        redirect_to user
      end
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
