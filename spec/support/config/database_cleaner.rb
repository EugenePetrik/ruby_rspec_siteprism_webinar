# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    # Before the entire test suite runs, clear the test database out completely
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    # Sets the default database cleanjing strategy to be transactions
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    # Chooses the "truncation" strategy if your Capybara use js driver
    DatabaseCleaner.strategy = :truncation, { cache_tables: false }
  end

  config.before do
    # Hook up database_cleaner around the beginning of each test
    DatabaseCleaner.start
  end

  config.append_after do
    # Hook up database_cleaner around the end of each test
    DatabaseCleaner.clean
  end
end
