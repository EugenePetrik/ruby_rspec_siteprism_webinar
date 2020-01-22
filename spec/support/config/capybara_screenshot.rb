# frozen_string_literal: true

require 'capybara-screenshot/rspec'

# Driver configuration
# https://github.com/mattheworiordan/capybara-screenshot#driver-configuration
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

# Keep only the screenshots generated from the last failing test suite
Capybara::Screenshot.prune_strategy = :keep_last_run

# Custom screenshot filename
# https://github.com/mattheworiordan/capybara-screenshot#custom-screenshot-filename
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  meta = example.metadata
  filename = File.basename(meta[:file_path])
  line_number = meta[:line_number]
  "screenshot_#{filename}-#{line_number}"
end

# Custom screenshot directory
# https://github.com/mattheworiordan/capybara-screenshot#custom-screenshot-directory
Capybara.save_path = 'tmp/capybara'
