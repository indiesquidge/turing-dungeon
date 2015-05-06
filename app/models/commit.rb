class Commit < ActiveRecord::Base
  validates :repo, :message, presence: true
  validates :sha, presence: true, uniqueness: true

  belongs_to :user

  def self.latest_commits
    User.all.each do |user|
      GithubService.event_data(user.nickname, user.name, ENV["GITHUB_ID"], ENV["GITHUB_SECRET"]).each do |event, commit|
        user.commits.create(repo: event[:repo][:name],
                            message: commit[:message],
                            sha: commit[:sha],
                            created_at: event[:created_at])
      end
    end
    order("created_at DESC").first(6)
  end

  def message_url
    "https://github.com/#{repo}/commit/#{sha}"
  end

  def repo_url
    "https://github.com/#{repo}"
  end
end
