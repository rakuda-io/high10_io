#database_cleanerの設定時に追記
# ENV["RAILS_ENV"] ||= 'test'
# require File.expand_path("../../config/environment", __FILE__)
# require 'rspec/rails'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  #database_cleanerの設定
  # config.before(:suite) do
  #   DatabaseCleaner.strategy = :truncation
  #   DatabaseCleaner.clean_with(:truncation)
  # end
  # config.before(:each) do
  #   DatabaseCleaner.start
  # end
  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end

end