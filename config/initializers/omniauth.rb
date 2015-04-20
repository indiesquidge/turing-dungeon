Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Figaro.env.GITHUB_ID, Figaro.env.GITHUB_SECRET
end
