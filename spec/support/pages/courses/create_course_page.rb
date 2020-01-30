# frozen_string_literal: true

class CreateCoursePage < BasePage
  set_url '/courses/new'

  element :course_header, '.header'
  element :name, '#course_name'
  element :short_name, '#course_short_name'
  element :description, '#course_description'
  element :create_course_button, '[name="button"]'

  def create_course_with(options = {})
    name.set(options[:name]) unless options[:name].nil?
    short_name.set(options[:short_name]) unless options[:short_name].nil?
    description.set(options[:description]) unless options[:description].nil?
    create_course_button.click
  end
end
