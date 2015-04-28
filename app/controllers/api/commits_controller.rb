class Api::CommitsController < ApplicationController
  force_ssl unless Rails.env.development?

  respond_to :json, :xml

  def show
    respond_with Commit.find(params[:id])
  end

  def index
    respond_with Commit.all
  end

  def create
    respond_with Commit.create(commit_params)
  end

  def update
    respond_with Commit.update(params[:id], commit_params)
  end

  def destroy
    respond_with Commit.destroy(params[:id])
  end

  private

  def commit_params
    params.require(:commit).permit(:message, :repo)
  end
end
