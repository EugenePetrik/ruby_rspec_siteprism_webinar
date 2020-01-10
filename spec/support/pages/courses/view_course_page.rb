# frozen_string_literal: true

class ViewCoursePage < BasePage
  set_url '/courses/{course_id}'

  element :course_title, '.card-title'
  element :course_description, :xpath, "//div[contains(@class, 'card-content')]/p[2]"
end
