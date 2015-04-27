require "rails_helper"

RSpec.describe "Dashboard", type: :feature do
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
