class Event < OpenStruct
  def self.service
    @service ||= GithubService.new
  end

  def self.all
    service.push_events.map { |event| new(event) }
  end
end
