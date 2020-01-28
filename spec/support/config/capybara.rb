require 'capybara/rails'
require 'capybara/rspec'
require 'webdrivers/chromedriver'

Capybara.register_driver(:chrome) do |app|
  CAPABILITIES = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: {
      browser: 'INFO'
    }
  )

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('window-size=1600,1268')
  options.add_argument('headless') unless /^(false|no|0)$/.match?(ENV['CHROME_HEADLESS'])

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
  config.default_max_wait_time = 3
  config.enable_aria_label = true
  config.ignore_hidden_elements = true
  config.server = :puma, { Silent: true }
  config.server_port = 54_321
end

RSpec.configure do |config|
  config.append_before(:each, type: :feature) do
    Capybara.reset_session!
  end

  config.append_after(:suite) do
    browser_logs = Capybara.page.driver.browser.manage.logs.get(:browser)

    Dir.mkdir('tmp/logs') unless Dir.exist?('tmp/logs')

    logs = browser_logs.map(&:to_s).join("\n\n")
    open('tmp/logs/chrome.log', 'w') { |f| f << logs }
  end
end
