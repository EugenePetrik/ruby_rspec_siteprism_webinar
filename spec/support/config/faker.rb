# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:all) do
    Faker::Config.random = Random.new(config.seed)
  end

  config.before do
    Faker::UniqueGenerator.clear
  end
end
