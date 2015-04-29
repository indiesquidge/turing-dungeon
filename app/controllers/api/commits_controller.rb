class Api::CommitsController < ApplicationController
  force_ssl unless Rails.env.development?

  respond_to :json, :xml

  def show
    respond_with Commit.find(params[:id])
  end

  def index
    respond_with Commit.all
  end
end
