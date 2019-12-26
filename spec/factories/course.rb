# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    name { Faker::Educator.course_name }
    short_name { Faker::Lorem.characters(number: (3..15)).upcase }
    description { Faker::Lorem.paragraph_by_chars(number: rand(10..300)) }
  end
end
