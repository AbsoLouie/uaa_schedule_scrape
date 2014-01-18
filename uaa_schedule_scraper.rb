require 'selenium-webdriver'
require 'rspec-expectations'
require 'debugger'

def setup
  @driver = Selenium::WebDriver.for :firefox
  @base_url = 'http://uaa.alaska.edu/'
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

def wait_for(seconds=5)
  Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
end

def displayed?(how, what)
  @driver.find_element(how, what).displayed?
  true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
end

run {
  @driver.get(@base_url + "/")
  @driver.find_element(:link, "Class Schedules").click
  Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, "term_input_id")).select_by(:text, "Spring Semester 2014")  
  @driver.find_element(:css, "option[value=\"201401\"]").click
  @driver.find_element(:id, "camp_id19").click
  sleep(3)
  @driver.find_element(:id, "subj_id1").click
  @driver.find_element(:css, "input[type=\"submit\"]").click
  File.open('text', 'w') { |file| file.write(@driver.page_source()) }
}