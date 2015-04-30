require "rails_helper"

RSpec.describe "Dashboard", type: :feature do
  xit "displays Commits across all users" do
    user = User.create!(nickname: "ClassicRichard")
    visit root_path
    within("#github-feed") do
      expect(page).to have_content(user.nickname)
    end
  end
end
