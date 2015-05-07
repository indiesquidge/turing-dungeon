class CohortsController < ApplicationController
  def show
    @cohort = Cohort.find_by(name: params[:cohort])
  end
end
