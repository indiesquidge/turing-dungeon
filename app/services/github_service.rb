class GithubService
  def self.event_data(nickname, name, github_id, github_secret)
    connection = Faraday.new(url: "https://api.github.com")
    user_events = parse(connection.get("users/#{nickname}/events/public?per_page=5&client_id=#{github_id}&client_secret=#{github_secret}"))
    user_events.select! { |event| event[:type] == "PushEvent" }
    user_events.flat_map do |event|
      event[:payload][:commits].select { |commit| commit[:author][:name] == name }.reverse.map { |commit| [event, commit] }
    end
  end

  private

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
