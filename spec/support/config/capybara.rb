# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'selenium-webdriver'

# Register Chrome
Capybara.register_driver(:selenium_chrome) do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('window-size=1600,1268')

  # Loggers Values: "OFF", "SEVERE", "WARNING", "INFO", "CONFIG", "FINE", "FINER", "FINEST", "ALL"
  # https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities

  CAPABILITIES = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: {
      browser: 'INFO', # Capture JavaScript errors in Browser
      driver: 'INFO' # Capture WebDriver severe errors
    }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: CAPABILITIES,
    options: options
  )
end

# Register Firefox
Capybara.register_driver(:selenium) do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_argument('window-size=1600,1268')

  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: options
  )
end

# Register Chrome Headless
Capybara.register_driver(:selenium_chrome_headless) do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('window-size=1600,1268')
  options.add_argument('headless')
  options.add_argument('disable-gpu')

  CAPABILITIES = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: {
      browser: 'INFO', # Capture JavaScript errors in Browser
      driver: 'INFO' # Capture WebDriver severe errors
    }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: CAPABILITIES,
    options: options
  )
end

# Register Firefox Headless
Capybara.register_driver(:selenium_headless) do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_argument('--headless')
  options.add_argument('--window-size=1600,1268')

  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: options
  )
end

# Which default browser do you want Selenium WebDriver to use?
# DRIVER=selenium_chrome => Selenium driving Chrome
# DRIVER=selenium_chrome_headless => Selenium driving Chrome in a headless configuration
# DRIVER=selenium => Selenium driving Firefox
# DRIVER=selenium_headless => Selenium driving Firefox in a headless configuration
# https://github.com/teamcapybara/capybara#selenium
if ENV['DRIVER']
  driver = ENV['DRIVER'].to_sym
  Capybara.default_driver = driver
  Capybara.javascript_driver = driver
else
  Capybara.default_driver = :selenium_chrome_headless
  Capybara.javascript_driver = :selenium_chrome_headless
end

Capybara.configure do |config|
  config.always_include_port = true
  config.asset_host = 'http://localhost:3000'
  config.default_max_wait_time = 3
  config.enable_aria_label = true
  config.ignore_hidden_elements = true
  config.server = :puma, { Silent: true }
  config.server_port = 54_321
end

RSpec.configure do |config|
  config.before(type: :feature) do
    Capybara.reset_session!
    Capybara.execute_script 'try { localStorage.clear() } catch(err) { }'
    Capybara.execute_script 'try { sessionStorage.clear() } catch(err) { }'
  end

  config.after(:suite) do
    browser_errors = Capybara.page.driver.browser.manage.logs.get(:browser)
    driver_errors = Capybara.page.driver.browser.manage.logs.get(:driver)

    Dir.mkdir('tmp/logs') unless Dir.exist?('tmp/logs')

    open('tmp/logs/chrome.log', 'w') { |f| f <<  browser_errors }
    open('tmp/logs/chromedriver.log', 'w') { |f| f << driver_errors }
  end
end
