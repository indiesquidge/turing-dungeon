class Api::UsersController < ApplicationController
  force_ssl if Rails.env.production?

  respond_to :json, :xml

  def show
    respond_with User.find(params[:id])
  end

  def index
    respond_with User.all
  end
end
