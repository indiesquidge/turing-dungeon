class UsersController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:username])
  end

  def edit
    @user = User.find_by(nickname: params[:username])
  end

  def update
    @user = User.find_by(nickname: params[:username])
    if @user.update_attributes(user_params)
      redirect_to @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:cohort_id)
  end
end
