# frozen_string_literal: true

require_relative 'sections/student_section'

class StudentsPage < BasePage
  set_url '/students'

  element :student_title, 'h3.center-align'

  sections :students, ::StudentSection, 'div[data-qa]'

  def student_names    
    students.map(&:name).map(&:text)
  end

  def open_student_profile_for(student_id)
    element = find(:xpath, "//div[@data-qa='#{student_id}']//a[text()='View Profile']")
    element.click
  end
end
