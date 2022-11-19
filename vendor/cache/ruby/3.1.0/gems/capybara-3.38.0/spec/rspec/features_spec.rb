# rubocop:disable RSpec/MultipleDescribes

require 'spec_helper'
require 'capybara/rspec'

# rubocop:disable RSpec/InstanceVariable
RSpec.configuration.before(:each, file_path: './spec/rspec/features_spec.rb') do
  @in_filtered_hook = true
end

describe "Capybara's feature DSL" do
  before do
    @in_background = true
  end

  it 'includes Capybara' do
    visit('/')
    expect(page).to have_content('Hello world!')
  end

  it 'preserves description' do |ex|
    expect(ex.metadata[:full_description])
      .to eq("Capybara's feature DSL preserves description")
  end

  it 'allows driver switching', driver: :selenium do
    expect(Capybara.current_driver).to eq(:selenium)
  end

  it 'runs background' do
    expect(@in_background).to be_truthy
  end

  it 'runs hooks filtered by file path' do
    expect(@in_filtered_hook).to be_truthy
  end

  it "doesn't pollute the Object namespace" do
    expect(Object.new).not_to respond_to(:feature)
  end

  describe 'nested features' do
    it 'work as expected' do
      visit '/'
      expect(page).to have_content 'Hello world!'
    end

    it 'are marked in the metadata as capybara_feature' do |ex|
      expect(ex.metadata[:capybara_feature]).to be_truthy
    end

    it 'have a type of :feature' do |ex|
      expect(ex.metadata[:type]).to eq :feature
    end
  end
end
# rubocop:enable RSpec/InstanceVariable

describe 'given and given! aliases to let and let!' do
  let(:value) { :available }
  let!(:value_in_background) { :available }

  before do
    expect(value_in_background).to be(:available)
  end

  it 'given and given! work as intended' do
    expect(value).to be(:available)
    expect(value_in_background).to be(:available)
  end
end

describe "Capybara's feature DSL with driver", driver: :culerity do
  it 'switches driver' do
    expect(Capybara.current_driver).to eq(:culerity)
  end
end

# rubocop:disable RSpec/RepeatedExample
xfeature 'if xfeature aliases to pending then' do
  it "this should be 'temporarily disabled with xfeature'" do
    # dummy
  end

  it "this also should be 'temporarily disabled with xfeature'" do
    # dummy
  end
end

ffeature 'if ffeature aliases focused tag then' do # rubocop:disable RSpec/Focus
  it 'scenario inside this feature has metatag focus tag' do |example|
    expect(example.metadata[:focus]).to be true
  end

  it 'other scenarios also has metatag focus tag' do |example|
    expect(example.metadata[:focus]).to be true
  end
end
# rubocop:enable RSpec/RepeatedExample, RSpec/MultipleDescribes
