class User < ActiveRecord::Base
  has_many   :commits
  belongs_to :cohort

  def self.find_or_create_from_auth(data)
    user = User.find_or_create_by(provider: data.provider, uid: data.uid)

    user.name      = data.info.name
    user.email     = data.info.email
    user.nickname  = data.info.nickname
    user.image_url = data.info.image
    user.token     = data.credentials.token
    user.save

    user
  end

  def github_profile_url
    "https://github.com/#{nickname}"
  end

  def to_param
    nickname
  end
end
