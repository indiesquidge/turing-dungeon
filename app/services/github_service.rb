class GithubService
  def initialize(github_id, github_secret)
    @github_id     = github_id
    @github_secret = github_secret
  end

  def event_data(nickname, name)
    connection = Faraday.new(url: "https://api.github.com")
    user_events = parse(connection.get("users/#{nickname}/events/public?per_page=5&client_id=#{@github_id}&client_secret=#{@github_secret}"))
    user_events.select { |event| event[:type] == "PushEvent" }.flat_map do |event|
      event[:payload][:commits].reverse.select { |commit| commit[:author][:name] == name }.map { |commit| [event, commit] }
    end
  end

  def latest_commits(users, number_of_commits)
    users.each do |user|
      event_data(user.nickname, user.name)
    end
  end

  private

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
