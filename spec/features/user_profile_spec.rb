require "rails_helper"

RSpec.describe "User Profile", type: :feature do
  it "displays only commit history for that user" do
    user1 = User.create!(nickname: "ClassicRichard", name: "Richard Mejia")
    user1.commits.create!(repo: "bartleby-rails",
                         message: "fuck fixtures",
                         sha: "abc")
    user2 = User.create!(nickname: "ArtVandelay", name: "Art Vandelay")
    user2.commits.create!(repo: "vandelay-industries",
                         message: "the architect",
                         sha: "cba")

    visit user_path(user1)
    within("#github-feed") do
      expect(page).to have_content(user1.commits.first.message)
      expect(page).to have_content(user1.commits.first.repo)
      expect(page).not_to have_content(user2.commits.first.message)
      expect(page).not_to have_content(user2.commits.first.repo)
    end
  end

  it "displays information about the user" do
    user = User.create!(nickname: "ClassicRichard",
                        name: "Richard Mejia")
    visit user_path(user)
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.nickname)
  end
end
