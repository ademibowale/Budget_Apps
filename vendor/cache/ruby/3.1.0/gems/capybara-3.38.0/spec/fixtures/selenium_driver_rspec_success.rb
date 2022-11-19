require 'spec_helper'
require 'selenium-webdriver'

RSpec.describe Capybara::Selenium::Driver do
  it 'should exit with a zero exit status' do
    options = { browser: ENV.fetch('SELENIUM_BROWSER', :firefox).to_sym }
    browser = described_class.new(TestApp, **options).browser
    expect(browser).to be_truthy
    expect(true).to be(true) # rubocop:disable RSpec/ExpectActual,RSpec/IdenticalEqualityAssertion
  end
end
