require "rails_helper"
require "webmock/rspec"
OmniAuth.config.test_mode = true

RSpec.describe "User authentication", type: :feature do
  it "can login with GitHub account" do
    visit root_path
    user = mock_omniauth_user

    within(".nav") do
      find("#github-login").click
    end

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
  end

  it "can logout if logged in" do
    visit root_path
    mock_omniauth_user
    Cohort.create!(name: "1412")

    within(".nav") do
      find("#github-login").click
    end

    mock_github_service_request
    click_on "Continue"

    within(".nav") do
      click_on "Logout"
    end

    expect(current_path).to eq(root_path)
  end
end

private

def mock_omniauth_user
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    "provider" => "github",
    "uid"      => "123456",
    "info" => {
      "email"    => "email@example.com",
      "nickname" =>  "mock_user",
      "image"    => "mock_user_thumbnail_url"
    },
    "credentials" => {
      "token"  => "mock_token"
    }
  })
end

def mock_github_service_request
  stub_request(:get, "https://api.github.com/users/mock_user/events/public?client_id=#{ENV['GITHUB_ID']}&client_secret=#{ENV['GITHUB_SECRET']}&per_page=5")
  .with(headers: {"Accept"=>"*/*", "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3", "User-Agent"=>"Faraday v0.9.1"})
  .to_return(status: 200, body: <<-JSON)
    [ { "type":       "PushEvent",
        "created_at": "2015-05-01T17:32:01Z",
        "repo":       { "name": "vandelay-industries" },
        "payload": {
          "commits": [
            { "sha": "c",
              "author": { "name": "Art Vandelay" },
              "message": "importing and exporting"
            }
          ]
        }
      }
    ]
  JSON
end
