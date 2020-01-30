# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:all) do
    # Faker supports seeding of its pseudo-random number generator to provide deterministic
    # output of repeated method calls - https://github.com/faker-ruby/faker#deterministic-random
    Faker::Config.random = Random.new(config.seed)
  end

  config.before do
    # Clears used values for all generators
    Faker::UniqueGenerator.clear
  end
end
