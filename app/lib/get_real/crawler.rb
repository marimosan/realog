require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
#require 'dotenv'

Capybara.configure do |config|
  config.run_server = false
  #config.current_driver = :poltergeist
  #config.javascript_driver = :poltergeist
  config.app_host =  ENV["TARGET_URL"]
  config.default_max_wait_time = 5
end

Capybara.current_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:timeout=>120, js_errors: false})
end

module GetReal
  class Crawler
    include Capybara::DSL
    def login
      page.driver.headers = { "User-Agent" => "Safari" }
      visit('/')
      begin
        fill_in "passwd", :with => ENV["ROOM_PASSWORD"]
        click_button "ログイン"
      rescue Exception => e
      end
    end

    def html
      page.html
    end

    def save(filename)
      wait_for_ajax
      save_page("#{filename}.html")
      page.save_screenshot("#{filename}.png", :full => true)
    end

    def wait_for_ajax
      sleep 2
      Timeout.timeout(Capybara.default_wait_time) do
        active = page.evaluate_script('jQuery.active')
        until active == 0
          sleep 1
          active = page.evaluate_script('jQuery.active')
        end
      end
    end
  end
end
