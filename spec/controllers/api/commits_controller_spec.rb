require "rails_helper"

RSpec.describe Api::CommitsController, type: :controller do
  it "can respond with all commits" do
    Commit.create(repo:    "bartleby-rails",
                  message: "fuck fixtures",
                  sha:     "abc")
    get :index, format: :json

    JSON.parse(response.body, symbolize_names: true)
    commit = Commit.first

    expect(response.code).to eq("200")
    expect(commit[:repo]).to eq("bartleby-rails")
    expect(commit[:message]).to eq("fuck fixtures")
  end

  it "can respons with a single commit" do
    commit = Commit.create(repo:    "bartleby-rails",
                           message: "fuck fixtures",
                           sha:     "abc")
    get :show, format: :json, id: commit.id

    JSON.parse(response.body, symbolize_names: true)

    expect(response.code).to eq("200")
    expect(commit[:repo]).to eq("bartleby-rails")
    expect(commit[:message]).to eq("fuck fixtures")
  end
end
