class GithubService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://api.github.com")
  end

  def push_events
    User.all.map do |user|
      parse(connection.get("users/#{user.nickname}/events/public?per_page=1&client_id=#{ENV['GITHUB_ID']}&client_secret=#{ENV['GITHUB_SECRET']}"))
    end.flatten.select { |event| event[:type] == "PushEvent" }
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
