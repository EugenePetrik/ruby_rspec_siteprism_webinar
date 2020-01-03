# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'selenium-webdriver'

Capybara.register_driver(:chrome) do |app|
  CAPABILITIES = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: {
      browser: 'ALL',
      client: 'ALL',
      driver: 'ALL',
      server: 'ALL'
    }
  )

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('window-size=1600,1268')
  # Run headless by default unless CHROME_HEADLESS specified
  options.add_argument('headless') unless /^(false|no|0)$/.match?(ENV['CHROME_HEADLESS'])
  options.add_argument('disable-gpu')

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: CAPABILITIES,
    options: options
  )
end

Capybara.configure do |config|
  config.always_include_port = true
  config.asset_host = 'http://localhost:3000'
  config.default_driver = :chrome
  config.javascript_driver = :chrome
  config.default_max_wait_time = 5
  config.enable_aria_label = true
  config.ignore_hidden_elements = true
  config.server = :puma, { Silent: true }
  config.server_port = 54_321
end

Capybara::Screenshot.prune_strategy = { keep: 20 }

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  meta = example.metadata
  filename = File.basename(meta[:file_path])
  line_number = meta[:line_number]
  "screenshot_#{filename}-#{line_number}"
end

RSpec.configure do |config|
  config.append_before(:each, type: :feature) do
    Capybara.reset_session!
    Capybara.execute_script 'try { localStorage.clear() } catch(err) { }'
    Capybara.execute_script 'try { sessionStorage.clear() } catch(err) { }'
  end

  config.append_after(:suite, type: :feature) do
    browser_errors = Capybara.page.driver.browser.manage.logs.get(:browser)
    client_errors = Capybara.page.driver.browser.manage.logs.get(:client)
    driver_errors = Capybara.page.driver.browser.manage.logs.get(:driver)
    server_errors = Capybara.page.driver.browser.manage.logs.get(:server)

    Dir.mkdir('tmp/logs') unless Dir.exist?('tmp/logs')

    open('tmp/logs/chrome.log', 'w') { |f| f <<  browser_errors }
    open('tmp/logs/client.log', 'w') { |f| f <<  client_errors }
    open('tmp/logs/chromedriver.log', 'w') { |f| f << driver_errors }
    open('tmp/logs/server.log', 'w') { |f| f << server_errors }
  end
end
