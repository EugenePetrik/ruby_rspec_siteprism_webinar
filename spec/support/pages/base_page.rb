# frozen_string_literal: true

class BasePage < SitePrism::Page
  # Navigation
  element :brand_title, 'a.brand-logo'
  element :courses, :xpath, '(//a[text()="Courses"])[1]'
  element :students, :xpath, '(//a[text()="Students"])[1]'
  element :account, 'a[data-target="dropdown1"]'

  # Footer
  element :brand_footer, :xpath, '//h5[text()="Tech University"]'
  element :info_title, :xpath, '//h5[text()="Information"]'
  element :help, 'a[href="/help"]'
  element :about, 'a[href="/about"]'
  element :contact_us, 'a[href="/contact_us"]'
  element :copyright, 'div.grey-text'

  # Flash messages
  element :flash_message, 'span.white-text'

  def nav_bar_visible?
    all_visible?(:brand_title, :courses)
  end

  def nav_bar_login_user_visible?
    all_visible?(:brand_title, :courses, :students, :account)
  end

  def footer_visible?
    all_visible?(:brand_footer, :info_title, :help, :about, :contact_us, :copyright)
  end

  private

  def all_visible?(*item_list)
    item_list.all? { |item| send(item).visible? }
  end
end
