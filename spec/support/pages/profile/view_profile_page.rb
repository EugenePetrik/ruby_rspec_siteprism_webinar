# frozen_string_literal: true

class ViewProfilePage < BasePage
  set_url '/students/{student_id}'

  COURSE_LINK_SELECTOR = 'data-qa'

  element :user_name, :xpath, '(//span[@class="card-title"])[1]'
  element :user_email, :xpath, '(//span[@class="card-title"]/following-sibling::p)[1]'
  element :edit_profile_button, 'a.waves-effect'
  element :course_enroll_title, :xpath, '(//span[@class="card-title"])[2]'
  elements :course_links, "li[#{COURSE_LINK_SELECTOR}] a"

  expected_elements :user_name, :user_email, :edit_profile_button, :course_enroll_title

  def click_to_edit_profile_button
    edit_profile_button.click
  end

  def courses_links
    course_links.map(&:text)
  end
end
