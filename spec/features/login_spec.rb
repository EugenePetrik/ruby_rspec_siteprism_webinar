# frozen_string_literal: true

RSpec.describe 'Login page' do
  let(:login_page) { LoginPage.new }
  let(:home_page) { HomePage.new }
  let(:student) { create(:student) }
  let(:message) { 'Something was wrong with your login information' }

  before { login_page.load }

  context 'when open page', :smoke do
    it { expect(login_page).to be_displayed }
    it { expect(login_page).to be_all_there }
    it { expect(login_page).to be_nav_bar_visible }
    it { expect(login_page).to be_footer_visible }
  end

  context 'with correct email and password', :smoke do
    let(:view_profile_page) { ViewProfilePage.new }

    it 'student logs in' do
      email = student.email
      password = student.password
      login_page.login_with(email, password)

      expect(view_profile_page).to be_displayed(student_id: /\d+/)
      expect(view_profile_page).to be_all_there
      expect(view_profile_page).to be_nav_bar_login_user_visible
      expect(view_profile_page).to be_footer_visible
    end
  end

  context 'with email in uppercase' do
    let(:view_profile_page) { ViewProfilePage.new }

    it 'student logs in' do
      email = student.email.upcase
      password = student.password
      login_page.login_with(email, password)

      expect(view_profile_page).to be_displayed(student_id: /\d+/)
      expect(view_profile_page).to be_all_there
    end
  end

  context 'with nonexistent email' do
    it 'raises an error' do
      email = "student_#{student.email.upcase}"
      password = student.password
      login_page.login_with(email, password)

      # expect(login_page.flash_message.text).to eq(message)
      expect(login_page.flash_message.text).to eq(I18n.t('logins.create.something_was_wrong'))
    end
  end

  context 'with empty email' do
    it 'raises an error' do
      login_page.login_with(' ', student.password)

      # expect(login_page).to have_content(message)
      expect(login_page).to have_content(I18n.t('logins.create.something_was_wrong'))
    end
  end

  context 'with incorrect password' do
    it 'raises an error' do
      email = student.email.upcase
      password = "pass_#{student.password}"
      login_page.login_with(email, password)

      # expect(login_page).to have_content(message)
      expect(login_page).to have_content(I18n.t('logins.create.something_was_wrong'))
    end
  end

  context 'with empty password' do
    it 'raises an error' do
      login_page.login_with(student.email.upcase, ' ')

      # expect(login_page).to have_content(message)
      expect(login_page).to have_content(I18n.t('logins.create.something_was_wrong'))
    end
  end
end
