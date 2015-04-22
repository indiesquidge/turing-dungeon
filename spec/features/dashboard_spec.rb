require "rails_helper"

RSpec.describe "Dashboard", type: :feature do
  it "displays a Twitter feed" do
    visit root_path
    within("#twitter-feed") do
      expect(page).to have_content("The path of the righteous man")
    end
  end

  it "displays last five commits across all users" do
    visit root_path
    within("#github-feed") do
      expect(page).to have_content("This is the commit message")
    end
  end
end
