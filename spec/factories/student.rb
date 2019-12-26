# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :with_courses do
      transient do
        courses_count { 1 }
      end

      after(:create) do |student, evaluator|
        student.courses << create_list(:course, evaluator.courses_count)
      end
    end
  end
end
