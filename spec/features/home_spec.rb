# frozen_string_literal: true

RSpec.describe 'Home page' do
  let(:login_page) { LoginPage.new }
  let(:home_page) { HomePage.new }
  let(:student) { create(:student) }
  let!(:course) { create_list(:course, 3) }
  let(:message) { "You have successfully enrolled in #{course[0].name}" }

  before do
    login_page.load
    login_page.login_with(student.email, student.password)
    home_page.load
  end

  context 'when open page', :smoke do
    it { expect(home_page).to be_displayed }
    it { expect(home_page).to be_all_there }
    it { expect(home_page).to be_nav_bar_login_user_visible }
    it { expect(home_page).to be_footer_visible }

    it 'shows title' do
      # expect(home_page.title).to eq('Tech University')
      expect(home_page.title).to eq(I18n.t('layouts.navigation.tech_university'))
    end

    it 'course cards are displayed' do
      expect(home_page.course_cards.size).to eq(3)
    end

    it 'course cards ids match' do
      expect(home_page.course_cards_ids)
        .to eq([course[0].id, course[1].id, course[2].id])
    end

    it 'course titles match' do
      expect(home_page.course_titles.map(&:text))
        .to match_array([course[0].name, course[1].name, course[2].name])
    end
  end

  context 'when click to enroll link', :smoke do
    let(:view_profile_page) { ViewProfilePage.new }

    it 'course enrolled' do
      home_page.course_enroll_with(course[0].id)

      expect(view_profile_page).to be_displayed
      expect(view_profile_page).to be_all_there

      # expect(view_profile_page.flash_message.text).to have_content(message)
      expect(view_profile_page.flash_message.text).to eq(I18n.t('success_enroll', course_name: course[0].name))

      expect(view_profile_page).to be_nav_bar_login_user_visible
      expect(view_profile_page).to be_footer_visible
    end
  end

  context 'when click to course info link', :smoke do
    let(:view_course_page) { ViewCoursePage.new }

    it 'course info page displayes' do
      home_page.open_course_info_for(course[0].id)

      expect(view_course_page).to be_displayed
      expect(view_course_page).to be_all_there
      expect(view_course_page.course_title.text).to eq(course[0].name)
      expect(view_course_page.course_description.text).to eq(course[0].description)
    end
  end
end
