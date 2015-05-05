require "rails_helper"

RSpec.describe Api::UsersController, type: :controller do
  it "can respond with all users" do
    User.create(name: "Richard Mejia", nickname: "ClassicRichard")
    get :index, format: :json

    JSON.parse(response.body, symbolize_names: true)
    user = User.first

    expect(response.code).to eq("200")
    expect(user[:name]).to eq("Richard Mejia")
    expect(user[:nickname]).to eq("ClassicRichard")
  end

  it "can respons with a single user" do
    user = User.create(name: "Richard Mejia", nickname: "ClassicRichard")
    get :show, format: :json, id: user.id

    JSON.parse(response.body, symbolize_names: true)

    expect(response.code).to eq("200")
    expect(user[:name]).to eq("Richard Mejia")
    expect(user[:nickname]).to eq("ClassicRichard")
  end
end
