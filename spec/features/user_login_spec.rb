require "rails_helper"
OmniAuth.config.test_mode = true

RSpec.describe "User authentication", type: :feature do
  it "can login with GitHub account" do
    visit root_path
    mock_omniauth_user

    within(".nav") do
      find("#github-login").click
    end

    expect(page).to have_content("mock_user")
    expect(page).to have_content("email@example.com")
  end

  xit "can logout if logged in" do
    visit root_path
    mock_omniauth_user

    within(".nav") do
      find("#github-login").click
    end
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
