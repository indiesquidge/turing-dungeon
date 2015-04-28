class Seed
  def call
    generate_users
    generate_commits
  end

  def generate_users
    5.times do
      user = User.create!(nickname:  Faker::Name.name,
                          email:     Faker::Internet.email,
                          image_url: Faker::Avatar.image)
      puts "Created user: #{user.nickname}"
    end
  end

  def generate_commits
    15.times do
      random_user = User.all.sample
      commit = Commit.create!(message: Faker::Hacker.say_something_smart,
                              repo: Faker::App.name,
                              user_id: random_user.id)
      puts "Created Commit #{commit.id} for user #{random_user.id}"
    end
  end

  def self.call
    new.call
  end
end

Seed.call
