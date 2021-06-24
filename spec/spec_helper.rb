# frozen_string_literal: true

require 'factory_bot'
require 'json_matchers/rspec'
require 'simplecov'

JsonMatchers.schema_root = 'spec/schemas'
SimpleCov.start

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.color = true
end
