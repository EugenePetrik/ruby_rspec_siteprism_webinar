# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    # Before the entire test suite runs, clear the test database out completely
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    # Sets the default database cleaning strategy to be transactions
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    # Chooses the "truncation" strategy if your Capybara use js driver
    DatabaseCleaner.strategy = :truncation, { cache_tables: false }
  end

  config.before do
    # Usually this is called in setup of a test
    DatabaseCleaner.start
  end

  config.append_after do
    # Cleanup of the test
    DatabaseCleaner.clean
  end
end
