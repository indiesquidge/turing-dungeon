class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:username])
  end
end
