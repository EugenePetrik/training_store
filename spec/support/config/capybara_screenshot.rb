require 'capybara-screenshot/rspec'

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara::Screenshot.prune_strategy = :keep_last_run

Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  meta = example.metadata
  filename = File.basename(meta[:file_path])
  line_number = meta[:line_number]
  "screenshot_#{filename}-#{line_number}"
end

Capybara.save_path = 'tmp/capybara'
