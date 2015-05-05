class Api::CommitsController < ApplicationController
  force_ssl if Rails.env.production?

  respond_to :json, :xml

  def index
    respond_with Commit.all
  end

  def show
    respond_with Commit.find(params[:id])
  end
end
