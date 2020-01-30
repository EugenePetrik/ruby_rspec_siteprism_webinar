# frozen_string_literal: true

require_relative '../sections/course_section'

class HomePage < BasePage
  set_url '/'

  element :course_title, 'h3.center-align'

  sections :courses, ::CourseSection, 'div[data-qa]'

  def course_titles
    courses.map(&:title).map(&:text)
  end

  def course_enroll_with(course_id)
    element = find(:xpath, "//div[@data-qa='#{course_id}']//a[text()='Enroll']")
    element.click
  end

  def open_course_info_for(course_id)
    element = find(:xpath, "//div[@data-qa='#{course_id}']//a[text()='Info']")
    element.click
  end
end
