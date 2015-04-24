require "rails_helper"

RSpec.describe "Dashboard", type: :feature do
  it "displays a Twitter feed" do
    tweet = Tweet.create!(message: "This is an exciting Turing tweet!",
                          owner:   "OHDungeon")
    visit root_path
    within("#twitter-feed") do
      expect(page).to have_content(tweet.message)
      expect(page).to have_content(tweet.owner)
    end
  end

  it "displays Commits across all users" do
    user   = User.create!(nickname: "ClassicRichard")
    commit = Commit.create!(message: "This is a commit",
                            user_id: user.id)
    visit root_path
    within("#github-feed") do
      expect(page).to have_content(commit.message)
      expect(page).to have_content(commit.user.nickname)
    end
  end
end
