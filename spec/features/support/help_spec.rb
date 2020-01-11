# frozen_string_literal: true

RSpec.describe 'Help page' do
  let(:login_page) { LoginPage.new }
  let(:help_page) { HelpPage.new }
  let(:student) { create(:student) }

  before do
    login_page.load
    login_page.login_with(student.email, student.password)
    help_page.load
  end

  context 'when open page', :smoke do
    it { expect(help_page).to be_displayed }
    it { expect(help_page).to be_all_there }
    it { expect(help_page).to be_nav_bar_login_user_visible }
    it { expect(help_page).to be_footer_visible }
  end
end
