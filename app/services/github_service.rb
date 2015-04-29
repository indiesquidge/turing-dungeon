class GithubService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://api.github.com")
  end

  def repo_commits(owner, repo)
    parse(connection.get("repos/#{owner}/#{repo}/commits"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
