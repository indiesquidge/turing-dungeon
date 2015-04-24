class DashboardController < ApplicationController
  def show
    @commits = Commit.all.sample(5)
    @tweets  = Tweet.all.sample(5)
  end
end
