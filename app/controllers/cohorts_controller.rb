class CohortsController < ApplicationController
  def show
    confirm_user_cohort
    @cohort = Cohort.find_by(name: params[:cohort])
  end
end
