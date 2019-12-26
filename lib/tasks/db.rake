# frozen_string_literal: true

namespace :db do
  desc 'Populate db data'
  namespace :test do
    desc 'Populate database'
    task populate: :environment do
      require 'factory_bot'
      require 'faker'

      puts "=========== 'Create Students' ==========="

      FactoryBot.create(:student, name: 'Joe Doe', email: 'test@test.com', password: '123456')

      10.times { FactoryBot.create(:student) }

      puts "=========== 'Create Courses' ==========="

      20.times { FactoryBot.create(:course) }

      puts "=========== 'Add Courses for Students' ==========="

      Student.all.each do |student|
        courses = Course.first(rand(1..20))
        student.courses << courses
      end
    end
  end
end
