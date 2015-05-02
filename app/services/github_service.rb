class GithubService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://api.github.com")
  end

  def event_data
    User.all.each do |user|
      user_events = parse(connection.get("users/#{user.nickname}/events/public?per_page=5&client_id=#{ENV['GITHUB_ID']}&client_secret=#{ENV['GITHUB_SECRET']}"))
      user_events.select! { |event| event[:type] == "PushEvent" }
      user_events.each do |event|
        event[:payload][:commits].select { |commit| commit[:author][:name] == user.name }.each do |commit|
          user.commits.create(repo: event[:repo][:name],
                              message: commit[:message],
                              sha: commit[:sha],
                              created_at: event[:created_at])
        end
      end
    end
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
