class Commit < ActiveRecord::Base
  validates :repo, :message, :created_at, presence: true
  validates :sha, presence: true, uniqueness: true

  belongs_to :user

  def self.service
    @service ||= GithubService.new
  end

  def self.grab_commits_from_api
    service.event_data
  end

  def self.latest_commits
    grab_commits_from_api
    order("created_at DESC").first(6)
  end
end
