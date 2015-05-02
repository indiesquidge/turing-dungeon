class DashboardController < ApplicationController
  def show
    @commits = Commit.latest_commits
  end
end
