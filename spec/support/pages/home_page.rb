# frozen_string_literal: true

class HomePage < BasePage
  set_url '/'

  COURSE_CARD_SELECTOR = 'data-qa'

  element :course_title, 'h3.center-align'
  elements :course_cards, "div[#{COURSE_CARD_SELECTOR}]"
  elements :course_titles, 'span.card-title'

  expected_elements :course_title

  def course_cards_ids
    course_cards.map { |course| course[COURSE_CARD_SELECTOR].to_i }
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
