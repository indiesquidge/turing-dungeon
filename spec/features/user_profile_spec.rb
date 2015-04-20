require "rails_helper"

RSpec.describe "Profile", type: :feature do
  it "displays the user's GitHub avatar" do
    visit profile_path
    within("#avatar") do
      expect(page).to have_css("img[src*='mock-user-profile.png']")
    end
  end
end
