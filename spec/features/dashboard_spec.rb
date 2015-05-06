require "rails_helper"
require "webmock/rspec"

RSpec.describe "Dashboard", type: :feature do
  it "displays Commits across all users" do
    user   = User.create!(nickname: "ClassicRichard", name: "Richard Mejia")
    stubbed_github_service_request
    visit root_path

    within("#github-feed") do
      expect(page).to have_content(user.nickname)
      expect(page).to have_content(user.commits.first.message)
      expect(page).to have_content(user.commits.first.repo)
    end
  end
end

private

def stubbed_github_service_request
  stub_request(:get, "https://api.github.com/users/ClassicRichard/events/public?client_id=&client_secret=&per_page=5")
    .with(headers: {"Accept"=>"*/*", "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "User-Agent"=>"Faraday v0.9.1"})
    .to_return(status: 200, body: <<-JSON)
      [ { "type":       "PushEvent",
          "created_at": "2015-05-01T17:32:01Z",
          "repo":       { "name": "bartleby-rails" },
          "payload": {
            "commits": [
              { "sha": "c",
                "author": { "name": "Richard Mejia" },
                "message": "I am such a troll"
              }
            ]
          }
        }
      ]
    JSON
end
