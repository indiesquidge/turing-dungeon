class DashboardController < ApplicationController
  def show
    @commits = GithubService.new(env, env).latest_commits(User.all, 10)
  end
end
