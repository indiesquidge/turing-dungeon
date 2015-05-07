require "codeclimate-test-reporter"
require "simplecov"
require "capybara/rspec"

CodeClimate::TestReporter.start
SimpleCov.start "rails"

RSpec.configure do |config|
  config.before(:all) do
    WebMock.disable_net_connect!
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.after(:all) do
    WebMock.allow_net_connect!
  end
end
