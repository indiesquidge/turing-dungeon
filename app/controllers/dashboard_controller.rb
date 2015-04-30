class DashboardController < ApplicationController
  def show
    @events = Event.all
  end
end
