# rubocop:disable RSpec/MultipleDescribes

require 'spec_helper'
require 'capybara/rspec'

RSpec.configuration.before(:each, file_path: './spec/rspec/scenarios_spec.rb') do
  @in_filtered_hook = true
end

describe 'if fscenario aliases focused tag then' do
  fscenario 'scenario should have focused meta tag' do |example| # rubocop:disable RSpec/Focus
    expect(example.metadata[:focus]).to be true
  end
end

describe 'if xscenario aliases to pending then' do
  xit "this test should be 'temporarily disabled with xscenario'" do
  end
end

# rubocop:enable RSpec/MultipleDescribes
