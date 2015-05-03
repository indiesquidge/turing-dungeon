require "rails_helper"
require "webmock/rspec"

RSpec.describe "Github Service" do
  before :each do
    stub_request(:get, "https://api.github.com/users/example_user/events/public")
      .with(headers: {"Accept"=>"*/*", "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "User-Agent"=>"Faraday v0.9.1"},
            query:   hash_including(client_id: "my_id", client_secret: "my_secret"),
           )
      .to_return(status: 200, body: <<-JSON)
      [ { "type":       "PullRequestEvent" },
        { "type":       "PushEvent",
          "created_at": "2015-05-01T17:32:01Z",
          "repo":       { "name": "turingschool/lightning_talks" },
          "payload": {
            "commits": [
              { "sha": "a",
                "author": { "name": "Markus Olsen" },
                "message": "message from Markus"
              },
              { "sha": "b",
                "author": { "name": "Rachel Warbelow" },
                "message": "second message from Rachel"
              },
              { "sha": "c",
                "author": { "name": "Rachel Warbelow" },
                "message": "first message from Rachel"
              }
            ]
          }
        }
      ]
    JSON
  end

  it "omits events that are not push events" do
    events = GithubService.event_data("example_user", "Rachel Warbelow", "my_id", "my_secret")
    expect(events.map { |e, _| e[:type] }.uniq).to eq(["PushEvent"])
  end
  it "omits commits that are not from the user" do
    events = GithubService.event_data("example_user", "Rachel Warbelow", "my_id", "my_secret")
    expect(events.map { |e,c| c[:author][:name] }.uniq).to eq(["Rachel Warbelow"])
  end
  it "returns commits in order" do
    events = GithubService.event_data("example_user", "Rachel Warbelow", "my_id", "my_secret")
    expect(events.map { |e,c| c[:sha] }).to eq(["c", "b"])
  end
end
