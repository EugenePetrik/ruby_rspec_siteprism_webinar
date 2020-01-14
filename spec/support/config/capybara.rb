# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'webdrivers/chromedriver'
require 'webdrivers/geckodriver'

# Capybara drivers - https://github.com/teamcapybara/capybara#drivers.

# Register Chrome browser.
Capybara.register_driver(:chrome) do |app|
  # https://selenium.dev/selenium/docs/api/rb/Selenium/WebDriver/Remote/Capabilities.html
  CAPABILITIES = Selenium::WebDriver::Remote::Capabilities.chrome(
    # Preferences for logging - https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities.
    # Logging Prefs: "browser", "driver", "client", "server".
    # Loggers Values: "OFF", "SEVERE", "WARNING", "INFO", "CONFIG", "FINE", "FINER", "FINEST", "ALL".
    loggingPrefs: {
      browser: 'ALL'
    }
  )

  # Add options for Chrome browser
  # https://selenium.dev/selenium/docs/api/rb/Selenium/WebDriver/Chrome/Options.html
  options = Selenium::WebDriver::Chrome::Options.new
  # Sets the initial window size.
  options.add_argument('window-size=1600,1268')
  # Run headless by default unless CHROME_HEADLESS specified.
  options.add_argument('headless') unless /^(false|no|0)$/.match?(ENV['CHROME_HEADLESS'])

  # Configuring and adding driver
  # https://github.com/teamcapybara/capybara#configuring-and-adding-drivers
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: CAPABILITIES,
    options: options
  )
end

# Configurable options
# https://www.rubydoc.info/github/jnicklas/capybara/Capybara#configure-class_method
Capybara.configure do |config|
  # Whether the Rack server's port should automatically be inserted into
  # every visited URL unless another port is explicitly specified.
  config.always_include_port = true
  # Where dynamic assets are hosted - will be prepended to relative asset locations if present.
  config.asset_host = 'http://localhost:3000'
  # The name of the driver to use by default.
  config.default_driver = :chrome
  # The name of a driver to use for JavaScript enabled tests.
  config.javascript_driver = :chrome
  # The maximum number of seconds to wait for asynchronous processes to finish (default 2 seconds).
  config.default_max_wait_time = 3
  # Whether fields, links, and buttons will match against aria-label attribute.
  config.enable_aria_label = true
  # Whether to ignore hidden elements on the page.
  config.ignore_hidden_elements = true
  # The name of the registered server to use when running the app under test.
  config.server = :puma, { Silent: true }
  # Tun all tests on localhost:54321.
  config.server_port = 54_321
end

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

RSpec.configure do |config|
  # Clear browser data before each test
  config.append_before(:each, type: :feature) do
    Capybara.reset_session!
  end

  # Save browser, client, driver, and server logs
  config.append_after(:suite) do
    # Gather logs
    browser_logs = Capybara.page.driver.browser.manage.logs.get(:browser)

    # Create tmp/logs folder if it does not exist
    Dir.mkdir('tmp/logs') unless Dir.exist?('tmp/logs')

    # Save logs to file
    open('tmp/logs/browser.log', 'w') { |f| f << browser_logs }
  end
end
