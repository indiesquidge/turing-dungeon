require "rails_helper"

RSpec.describe "Dashboard", type: :feature do
  it "displays a Twitter feed" do
    visit root_path
    within("ul#twitter-feed") do
      expect(page).to have_content("here is a tweet")
    end
  end

  it "displays last five commits across all users" do
    visit root_path
    within("ul#github-feed") do
      expect(page).to have_content("here is a commit")
    end
  end
end
